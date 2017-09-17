//
//  DistanceKeyboard.swift
//  RunTime
//
//  Created by Kayla Pandza on 20one7-09-one7.
//  Copyright © 20one7 Wes Ong. All rights reserved.
//

import Foundation
import SpriteKit

class DistanceKeyboard: SKSpriteNode {

    var thousands: Int = 1 {
        didSet {
            if thousands < 0 {
                thousands = 0
            }
            if thousands > 9 {
                thousands = 9
            }
            GameScene.distance = thousands*1000 + hundreds*100 + tens*10 + ones
        }
    }
    
    var hundreds: Int = 0{
        didSet {
            if hundreds < 0 {
                hundreds = 0
            }
            if hundreds > 9 {
                hundreds = 9
            }
              GameScene.distance = thousands*1000 + hundreds*100 + tens*10 + ones
        }
    }
    
    var tens: Int = 0 {
        didSet {
            if tens < 0 {
                tens = 0
            }
            if tens > 5 {
                tens = 5
            }
              GameScene.distance = thousands*1000 + hundreds*100 + tens*10 + ones
        }
    }
    
    var ones: Int = 0 {
        didSet {
            if ones < 0 {
                ones = 0
            }
            if ones > 9 {
                ones = 9
            }
            GameScene.distance = thousands*1000 + hundreds*100 + tens*10 + ones
        }
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
        
        for element in self.children {
            for _ in element.children {
                (element.childNode(withName: "up") as! MSButtonNode).selectedHandler = {
                    switch (element.name)! {
                    case "1000s":
                        self.thousands += 1
                        (element as! SKLabelNode).text = String(self.thousands)
                    case "100s":
                        self.hundreds += 1
                        (element as! SKLabelNode).text = String(self.hundreds)
                    case "10s":
                        self.tens += 1
                        (element as! SKLabelNode).text = String(self.tens)
                    case "1s":
                        self.ones += 1
                        (element as! SKLabelNode).text = String(self.ones)
                    default:
                        print("ERROR")
                    }
                }
                (element.childNode(withName: "down") as! MSButtonNode).selectedHandler = {
                    switch (element.name)! {
                    case "1000s":
                        self.thousands -= 1
                        (element as! SKLabelNode).text = String(self.thousands)
                    case "100s":
                        self.hundreds -= 1
                        (element as! SKLabelNode).text = String(self.hundreds)
                    case "10s":
                        self.tens -= 1
                        (element as! SKLabelNode).text = String(self.tens)
                    case "1s":
                        self.ones -= 1
                        (element as! SKLabelNode).text = String(self.ones)
                    default:
                        print("ERROR")
                    }
                    
                }
            }
        }
    }
    
    
    /* You are required to implement this for your subclass to work */
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
}
