//
//  BGClass.swift
//  Gravity Runner
//
//  Created by Bryce Sulin on 5/14/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3;
        }
    }
}






























