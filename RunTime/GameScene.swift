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
import Alamofire

class GameScene: SKScene {
    
    /* Set up app elements */
    var beginButton: MSButtonNode!
    var continueButton: MSButtonNode!
    var completeButton: MSButtonNode!
    var runAgainButton: MSButtonNode!
    var logo: SKSpriteNode!
    var cameraNode: SKCameraNode!
    
    /* Set up camera animations */
    var moveToStartMenu : SKAction = SKAction.init(named: "MoveToStartMenu")!
    var moveToSelectionMenu : SKAction = SKAction.init(named: "MoveToSelectionMenu")!
    var moveToDisplayMenu : SKAction = SKAction.init(named: "MoveToDisplayMenu")!
    var moveToCompletionMenu : SKAction = SKAction.init(named: "MoveToCompletionMenu")!
    
    /* Set up app animations */
    var fadeInAnimation : SKAction = SKAction.fadeIn(withDuration: 1)
    
    override func didMove(to view: SKView) {
        
        /* Disable multitouch */
        self.view?.isMultipleTouchEnabled = false
        
        /* Set up camera node */
        cameraNode = childNode(withName: "cameraNode") as! SKCameraNode
        self.camera = cameraNode
        
        /* Initialize begin button */
        beginButton = self.childNode(withName: "beginButton") as! MSButtonNode
        beginButton.selectedHandler = { [unowned self] in
            if !self.cameraNode.hasActions() {
            self.cameraNode.run(self.moveToSelectionMenu)
            }
        }
        
        /* Disable touch */
        beginButton.isUserInteractionEnabled = false
        
        
        /* Initialize start button */
        continueButton = self.childNode(withName: "continueButton") as! MSButtonNode
        continueButton.selectedHandler = { [unowned self] in
            if !self.cameraNode.hasActions() {
            self.cameraNode.run(self.moveToDisplayMenu)
            }
        }
        
        /* Initialize completed button */
        completeButton = self.childNode(withName: "completeButton") as! MSButtonNode
        completeButton.selectedHandler = { [unowned self] in
            if !self.cameraNode.hasActions() {
            self.cameraNode.run(self.moveToCompletionMenu)
            }
        }
        
        /* Initialize run again button */
        runAgainButton = self.childNode(withName: "runAgainButton") as! MSButtonNode
        runAgainButton.selectedHandler = { [unowned self] in
            if !self.cameraNode.hasActions() {
            self.cameraNode.run(self.moveToStartMenu)
            }
        }
        
        /* Iniialize logo */
        logo = self.childNode(withName: "logo") as! SKSpriteNode
        
        logo.run(fadeInAnimation) { [unowned self] in
            self.beginButton.run(self.fadeInAnimation)
            self.beginButton.isUserInteractionEnabled = true
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
