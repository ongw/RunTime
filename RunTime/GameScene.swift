//
//  GameScene.swift
//  RunTime
//
//  Created by Wes Ong on 2017-09-16.
//  Copyright © 2017 Wes Ong. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    /* Set up app elements */
    var beginButton: MSButtonNode!
    var continueButton: MSButtonNode!
    var completeButton: MSButtonNode!
    var runAgainButton: MSButtonNode!
    var logo: SKSpriteNode!
    var cameraNode: SKCameraNode!
    
    /* Set up selection elements */
    var timeButton: MSButtonNode!
    var distanceButton: MSButtonNode!
    var moneyButton: MSButtonNode!
    var moneyKeyboard: MoneyKeyboard!
    var timeKeyboard: TimeKeyboard!
    var distanceKeyboard: DistanceKeyboard!
    static var timeLabel: SKLabelNode!
    static var time : String! {
        didSet {
            GameScene.timeLabel.text = GameScene.time
        }
    }
    static var distanceLabel: SKLabelNode!
    static var distance : Int! {
        didSet {
            GameScene.distanceLabel.text = "\(GameScene.distance!)m"
        }
        
    }
    static var moneyLabel: SKLabelNode!
    static var money : Double! {
        didSet {
            GameScene.moneyLabel.text = "$\(GameScene.money!)"
        }
        
    }
    
    
    
    /* Set up camera animations */
    var moveToStartMenu : SKAction = SKAction.init(named: "MoveToStartMenu")!
    var moveToSelectionMenu : SKAction = SKAction.init(named: "MoveToSelectionMenu")!
    var moveToDisplayMenu : SKAction = SKAction.init(named: "MoveToDisplayMenu")!
    var moveToCompletionMenu : SKAction = SKAction.init(named: "MoveToCompletionMenu")!
    
    /* Set up app animations */
    var fadeInAnimation : SKAction = SKAction.fadeIn(withDuration: 1)
    var moveKeyboardUp : SKAction = SKAction.init(named: "MoveUpKeyboard")!
    var moveKeyboardDown : SKAction = SKAction.init(named: "MoveDownKeyboard")!
    
    var timerLabel: SKLabelNode!
    var time : Int = 0 {
        didSet {
            self.timerLabel.text = "6:59:\(self.time)"
        }
    }
    var timerOn: Bool = false
    
    var finalDistanceLabel: SKLabelNode!
    var distanceTravelled: Double = 0.0 {
        didSet {
            self.finalDistanceLabel.text = "\(abs(Int(distanceTravelled)))/1400m"
        }
    }
    
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
            self.time = 59
            self.timerOn = true
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
        
        /* Initialize logo */
        logo = self.childNode(withName: "logo") as! SKSpriteNode
        
        logo.run(fadeInAnimation) { [unowned self] in
            self.beginButton.run(self.fadeInAnimation)
            self.beginButton.isUserInteractionEnabled = true
        }
        
        moneyKeyboard = self.childNode(withName: "moneyKeyboard") as! MoneyKeyboard
        timeKeyboard = self.childNode(withName: "timeKeyboard") as! TimeKeyboard
        distanceKeyboard = self.childNode(withName: "distanceKeyboard") as! DistanceKeyboard
        
        /* Initialize time button */
        timeButton = self.childNode(withName: "timeButton") as! MSButtonNode
        timeButton.selectedHandler = { [unowned self] in
            /* Bring up keyboard */
            self.timeKeyboard.run(self.moveKeyboardUp)
            self.moneyKeyboard.run(self.moveKeyboardDown)
            self.distanceKeyboard.run(self.moveKeyboardDown)
            self.continueButton.isHidden = true
            
        }
        GameScene.timeLabel = timeButton.childNode(withName: "timeLabel") as! SKLabelNode
        
        /* Initialize money button */
        moneyButton = self.childNode(withName: "moneyButton") as! MSButtonNode
        moneyButton.selectedHandler = { [unowned self] in
            /* Bring up keyboard */
            self.timeKeyboard.run(self.moveKeyboardDown)
            self.moneyKeyboard.run(self.moveKeyboardUp)
            self.distanceKeyboard.run(self.moveKeyboardDown)
            self.continueButton.isHidden = true
            
            
        }
        GameScene.moneyLabel = moneyButton.childNode(withName: "moneyLabel") as! SKLabelNode
        
        /* Initialize distance button */
        distanceButton = self.childNode(withName: "distanceButton") as! MSButtonNode
        distanceButton.selectedHandler = { [unowned self] in
            /* Bring up keyboard */
            self.timeKeyboard.run(self.moveKeyboardDown)
            self.moneyKeyboard.run(self.moveKeyboardDown)
            self.distanceKeyboard.run(self.moveKeyboardUp)
            self.continueButton.isHidden = true
            
        }
        
        GameScene.distanceLabel = distanceButton.childNode(withName: "distanceLabel") as! SKLabelNode
        
        finalDistanceLabel = self.childNode(withName: "finalDistanceLabel") as! SKLabelNode
        timerLabel = self.childNode(withName: "timerLabel") as! SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Bring down all keyboards */
        self.timeKeyboard.run(self.moveKeyboardDown)
        self.moneyKeyboard.run(self.moveKeyboardDown)
        self.distanceKeyboard.run(self.moveKeyboardDown)
        self.continueButton.isHidden = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if timerOn {
            if !timerLabel.hasActions(){
                
                /* Run animation and decrement timer */
                timerLabel.run(SKAction.wait(forDuration: 1)) { [unowned self] in
                    self.time -= 1
                    
                    if let accelerometerData = GameViewController.motionManager.accelerometerData{
                        
                        let speed = accelerometerData.acceleration.z*1;
                        
                         self.distanceTravelled +=  speed*0.5;
                        
                        print(self.distanceTravelled)
                        
                    }
                }
            }
        }
    }
}
