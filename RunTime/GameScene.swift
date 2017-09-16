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
    var startButton: MSButtonNode!
    var completeButton: MSButtonNode!
    var runAgainButton: MSButtonNode!
    var cameraNode: SKCameraNode!
    
    /* Set up camera animations */
    var moveToStartMenu : SKAction = SKAction.init(named: "MoveToStartMenu")!
    var moveToSelectionMenu : SKAction = SKAction.init(named: "MoveToSelectionMenu")!
    var moveToDisplayMenu : SKAction = SKAction.init(named: "MoveToDisplayMenu")!
    var moveToCompletionMenu : SKAction = SKAction.init(named: "MoveToCompletionMenu")!
    
    /* Set up payment elements */
    var baseURLString: String? = nil
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
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
            self.cameraNode.run(self.moveToSelectionMenu)
        }
        
        /* Initialize start button */
        startButton = self.childNode(withName: "startButton") as! MSButtonNode
        startButton.selectedHandler = { [unowned self] in
            self.cameraNode.run(self.moveToDisplayMenu)
        }
        
        /* Initialize completed button */
        completeButton = self.childNode(withName: "completeButton") as! MSButtonNode
        completeButton.selectedHandler = { [unowned self] in
            self.cameraNode.run(self.moveToCompletionMenu)
        }
        
        /* Initialize run again button */
        runAgainButton = self.childNode(withName: "runAgainButton") as! MSButtonNode
        runAgainButton.selectedHandler = { [unowned self] in
            self.cameraNode.run(self.moveToStartMenu)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        Alamofire.request(url, method: .post, parameters: [
            "api_version": apiVersion,
            ])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
