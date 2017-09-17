//
//  GameViewController.swift
//  RunTime
//
//  Created by Wes Ong on 2017-09-16.
//  Copyright © 2017 Wes Ong. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Stripe

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*
    @IBAction func donate(sender: AnyObject) {
        
        // Initiate the card
        var stripCard = STPCard()
        
        // Split the expiration date to extract Month & Year
        if self.expireDateTextField.text.isEmpty == false {
            let expirationDate = self.expireDateTextField.text.componentsSeparatedByString("/")
            let expMonth = UInt(expirationDate[0].toInt()!)
            let expYear = UInt(expirationDate[1].toInt()!)
            
            // Send the card info to Strip to get the token
            stripCard.number = self.cardNumberTextField.text
            stripCard.cvc = self.cvcTextField.text
            stripCard.expMonth = expMonth
            stripCard.expYear = expYear
        }
        
        var underlyingError: NSError?
        stripCard.validateCardReturningError(&underlyingError)
        if underlyingError != nil {
            self.spinner.stopAnimating()
            self.handleError(underlyingError!)
            return
        }
        
        STPAPIClient.sharedClient().createTokenWithCard(stripCard, completion: { (token, error) -> Void in
            
            if error != nil {
                self.handleError(error!)
                return
            }
            
            self.postStripeToken(token!)
        })
        
        func handleError(error: NSError) {
            UIAlertView(title: "Please Try Again",
                        message: error.localizedDescription,
                        delegate: nil,
                        cancelButtonTitle: "OK").show()
            
        }
    }
    
    func postStripeToken(token: STPToken) {
        
        let URL = "http://localhost/donate/payment.php"
        let params = ["stripeToken": token.tokenId,
                      "amount": self.amountTextField.text.toInt()!,
                      "currency": "usd",
                      "description": self.emailTextField.text]
        
        let manager = AFHTTPRequestOperationManager()
        manager.POST(URL, parameters: params, success: { (operation, responseObject) -> Void in
            
            if let response = responseObject as? [String: String] {
                UIAlertView(title: response["status"],
                            message: response["message"],
                            delegate: nil,
                            cancelButtonTitle: "OK").show()
            }
            
        }) { (operation, error) -> Void in
            self.handleError(error!)
        }
    }
    */
}
