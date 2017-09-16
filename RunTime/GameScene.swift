//
//  GameScene.swift
//  RunTime
//
//  Created by Wes Ong on 2017-09-16.
//  Copyright © 2017 Wes Ong. All rights reserved.
//

import SpriteKit
import GameplayKit
import Stripe

class GameScene: SKScene {
    
    /* Set up app elements */
    var startButton: MSButtonNode!
    var cameraNode: SKCameraNode!
    
    override func didMove(to view: SKView) {
        
        /* Disable multitouch */
        self.view?.isMultipleTouchEnabled = false
        
        /* Set up camera node */
        cameraNode = childNode(withName: "cameraNode") as! SKCameraNode
        self.camera = cameraNode
        
        /* Initialize start button */
        startButton = self.childNode(withName: "startButton") as! MSButtonNode
        startButton.selectedHandler {
            System.out.print("START")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
