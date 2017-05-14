//
//  Player.swift
//  Gravity Runner
//
//  Created by Bryce Sulin on 5/14/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import SpriteKit

struct ColliderType {
    
    static let PLAYER: UInt32 = 0;
    static let GROUND: UInt32 = 1;
    static let ROCKET_AND_COLLECTABLES: UInt32 = 2;
}

class Player: SKSpriteNode {
    
    private var playerAnimation = [SKTexture]();
    private var animatePlayerAction = SKAction();
    
    func initializePlayer() {
        name = "Player";
        
        for i in 1...6 {
            let name = "Player \(i)";
            playerAnimation.append(SKTexture(imageNamed: name));
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false);
        
        self.run(SKAction.repeatForever(animatePlayerAction));
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 40, height: self.size.height));
        physicsBody?.affectedByGravity = true;
        physicsBody?.allowsRotation = false;
        physicsBody?.restitution = 0;
        physicsBody?.categoryBitMask = ColliderType.PLAYER;
        physicsBody?.collisionBitMask = ColliderType.GROUND;
        physicsBody?.contactTestBitMask = ColliderType.ROCKET_AND_COLLECTABLES;
    }
    
    func move() {
        self.position.x += 10;
    }
    
    func reversePlayer() {
        self.yScale *= -1;
    }
    
}
