//
//  GroundClass.swift
//  Gravity Runner
//
//  Created by Bryce Sulin on 5/14/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import SpriteKit

class GroundClass: SKSpriteNode {
    
    func initializeGroundAndFloor() {
        physicsBody = SKPhysicsBody(rectangleOf: self.size);
        physicsBody?.affectedByGravity = false;
        physicsBody?.isDynamic = false;
        physicsBody?.categoryBitMask = ColliderType.GROUND;
    }
    
    func moveGroundOrFloors(camera: SKCameraNode) {
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3;
        }
    }
}



























