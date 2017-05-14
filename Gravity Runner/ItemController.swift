//
//  ItemController.swift
//  Gravity Runner
//
//  Created by Bryce Sulin on 5/14/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import SpriteKit

class ItemController {
    
    private var minY = CGFloat(-263), maxY = CGFloat(263);
    
    func spawnItems(camera: SKCameraNode) -> SKSpriteNode {
        
        let item: SKSpriteNode?;
        
        if Int(randomBetweenNumbers(nfirstNum: 0, secondNum: 10)) >= 6 {
            item = SKSpriteNode(imageNamed: "Rocket");
            item?.name = "Rocket";
            item?.setScale(0.7);
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size);
        } else {
            item = SKSpriteNode(imageNamed: "Coin");
            item?.name = "Coin";
            item?.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2);
        }
        
        item!.physicsBody?.affectedByGravity = false;
        item?.physicsBody?.categoryBitMask = ColliderType.ROCKET_AND_COLLECTABLES;
        
        item?.zPosition = 4;
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        item?.position.x = camera.position.x + 900;
        item?.position.y = randomBetweenNumbers(nfirstNum: minY, secondNum: maxY);
        
        return item!;
    }
    
    
    func randomBetweenNumbers(nfirstNum: CGFloat, secondNum: CGFloat)
        -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(nfirstNum - secondNum) + min(nfirstNum, secondNum);
    }
    
}
