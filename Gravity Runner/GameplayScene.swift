//
//  GameplayScene.swift
//  Gravity Runner
//
//  Created by Bryce Sulin on 5/14/17.
//  Copyright © 2017 BryceSulin. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    private var bg1: BGClass?;
    private var bg2: BGClass?;
    private var bg3: BGClass?;
    
    private var ground1: GroundClass?;
    private var ground2: GroundClass?;
    private var ground3: GroundClass?;
    
    private var floor1: GroundClass?;
    private var floor2: GroundClass?;
    private var floor3: GroundClass?;

    private var player: Player?;


    private var mainCamera: SKCameraNode?;
    private var scoreLabel: SKLabelNode?;
    private var score = 0;
    
    private var itemController = ItemController();
    
    override func didMove(to view: SKView) {
        initializeGame();
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        manageCamera();
        manageBGsAndGrounds();
        player?.move();
        moveRocket();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reverseGravity();
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        }
        else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            score += 1;
            scoreLabel?.text = String(score);
            secondBody.node?.removeFromParent();
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Rocket" {
            firstBody.node?.removeFromParent();
            secondBody.node?.removeFromParent();
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.restartGame), userInfo: nil, repeats: false);
            
        }
    }
    
    private func initializeGame() {
        
        physicsWorld.contactDelegate = self;
        mainCamera = childNode(withName: "MainCamera") as?
            SKCameraNode!;
        
        bg1 = childNode(withName: "BG1") as? BGClass!;
        bg2 = childNode(withName: "BG2") as? BGClass!;
        bg3 = childNode(withName: "BG3") as? BGClass!;
        
        ground1 = childNode(withName: "Ground1") as? GroundClass!;
        ground2 = childNode(withName: "Ground2") as? GroundClass!;
        ground3 = childNode(withName: "Ground3") as? GroundClass!;
        
        ground1?.initializeGroundAndFloor();
        ground2?.initializeGroundAndFloor();
        ground3?.initializeGroundAndFloor();
        
        floor1 = childNode(withName: "Floor1") as? GroundClass!;
        floor2 = childNode(withName: "Floor2") as? GroundClass!;
        floor3 = childNode(withName: "Floor3") as? GroundClass!;
        
        floor1?.initializeGroundAndFloor();
        floor2?.initializeGroundAndFloor();
        floor3?.initializeGroundAndFloor();
        
        player = childNode(withName: "Player") as? Player!;
        player?.initializePlayer();
        
        scoreLabel = mainCamera!.childNode(withName: "ScoreLabel") as? SKLabelNode;
        scoreLabel?.text = "0";
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(nfirstNum: 2, secondNum: 4)), target: self, selector: #selector(GameplayScene.removeItems), userInfo: nil, repeats: true);
        
        
        Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector(GameplayScene.spawnItems), userInfo: nil, repeats: true);
        
    }
    
    private func manageCamera() {
        self.mainCamera?.position.x += 10;
        
    }
    
    
    private func manageBGsAndGrounds() {
        bg1?.moveBG(camera: mainCamera!);
        bg2?.moveBG(camera: mainCamera!);
        bg3?.moveBG(camera: mainCamera!);
        
        ground1?.moveGroundOrFloors(camera: mainCamera!);
        ground2?.moveGroundOrFloors(camera: mainCamera!);
        ground3?.moveGroundOrFloors(camera: mainCamera!);

        floor1?.moveGroundOrFloors(camera: mainCamera!);
        floor2?.moveGroundOrFloors(camera: mainCamera!);
        floor3?.moveGroundOrFloors(camera: mainCamera!);

    }
    
    private func reverseGravity() {
        physicsWorld.gravity.dy *= -1;
        player?.reversePlayer();
    }
    
    func spawnItems() {
        self.scene?.addChild(itemController.spawnItems(camera: mainCamera!));
    }
    
    func restartGame() {
        if let scene = GameplayScene(fileNamed: "GameplayScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 1));
        }
    }
    
    private func moveRocket() {
        enumerateChildNodes(withName: "Rocket", using: ({
            (node, error) in
            node.position.x -= 5;
        }))
    }
    
    func removeItems() {
        for child in children {
            if child.name == "Coin" || child.name == "Rocket" {
                if child.position.x < self.mainCamera!.position.x - self.scene!.frame.width / 2 {
                    child.removeFromParent();
                }
            }
        }
    }
}
