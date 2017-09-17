//
//  TimeKeyboard.swift
//  RunTime
//
//  Created by Kayla Pandza on 2017-09-17.
//  Copyright © 2017 Wes Ong. All rights reserved.
//

import Foundation
import SpriteKit

class TimeKeyboard: SKSpriteNode {
       
    static var secTime: Double!
    
    var hr10: Int = 1 {
        didSet {
            if hr10 < 0 {
                hr10 = 0
            }
            if hr10 > 2 {
                hr10 = 2
            }
            if hr10 == 2 && hr1 > 4 {
                hr1 = 4
            }
            TimeKeyboard.secTime = Double (hr10 * 10 * 60 * 60 + hr1 * 60 * 60 + min10 * 60 + min1 * 60)
            GameScene.time = "\(hr10)\(hr1):\(min10)\(min1)hr"
        }
    }
    
    var hr1: Int = 0{
        didSet {
            if hr1 < 0 {
                hr1 = 0
            }
            if hr1 > 9 {
                hr1 = 9
            }
            if hr10 == 2 && hr1 > 4 {
                hr1 = 4
            }
            TimeKeyboard.secTime = Double (hr10 * 10 * 60 * 60 + hr1 * 60 * 60 + min10 * 60 + min1 * 60)
            GameScene.time = "\(hr10)\(hr1):\(min10)\(min1)hr"
        }
    }
    
    var min10: Int = 0 {
        didSet {
            if min10 < 0 {
                min10 = 0
            }
            if min10 > 5 {
                min10 = 5
            }
            TimeKeyboard.secTime = Double (hr10 * 10 * 60 * 60 + hr1 * 60 * 60 + min10 * 60 + min1 * 60)
            GameScene.time = "\(hr10)\(hr1):\(min10)\(min1)hr"
        }
    }
    
    var min1: Int = 0 {
        didSet {
            if min1 < 0 {
                min1 = 0
            }
            if min1 > 9 {
                min1 = 9
            }
            TimeKeyboard.secTime = Double (hr10 * 10 * 60 * 60 + hr1 * 60 * 60 + min10 * 60 + min1 * 60)
            GameScene.time = "\(hr10)\(hr1):\(min10)\(min1)hr"
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
                    case "hr10":
                        self.hr10 += 1
                        (element as! SKLabelNode).text = String(self.hr10)
                    case "hr1":
                        self.hr1 += 1
                        (element as! SKLabelNode).text = String(self.hr1)
                    case "min10":
                        self.min10 += 1
                        (element as! SKLabelNode).text = String(self.min10)
                    case "min1":
                        self.min1 += 1
                        (element as! SKLabelNode).text = String(self.min1)
                    default:
                        print("ERROR")
                    }
                }
                (element.childNode(withName: "down") as! MSButtonNode).selectedHandler = {
                    switch (element.name)! {
                    case "hr10":
                        self.hr10 -= 1
                        (element as! SKLabelNode).text = String(self.hr10)
                    case "hr1":
                        self.hr1 -= 1
                        (element as! SKLabelNode).text = String(self.hr1)
                    case "min10":
                        self.min10 -= 1
                        (element as! SKLabelNode).text = String(self.min10)
                    case "min1":
                        self.min1 -= 1
                        (element as! SKLabelNode).text = String(self.min1)
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
