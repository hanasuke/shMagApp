//
//  GameScene.swift
//  shMagApp
//
//  Created by naosuke on 4/10/16.
//  Copyright (c) 2016 naosuke.me. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var interval:CFTimeInterval!

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = SKColor.blackColor()

        for _ in 1...20 {
            createEnemy()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            if touchedNode.name == "Spaceship" {
                touchedNode.removeFromParent()
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if interval == nil {
            interval = currentTime
        }

        if interval + 1 <= currentTime {
            createEnemy()

            interval = currentTime
        }

        if self.children.count < 10 {
            interval = 99999
            let finishLabel = SKLabelNode()
            finishLabel.text = "You Win!"
            finishLabel.fontSize = 40
            finishLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        }
    }

    func createEnemy() {
        let sprite = SKSpriteNode(imageNamed: "Spaceship")
        sprite.xScale = 0.2
        sprite.yScale = 0.2
        sprite.name = "Spaceship"

        sprite.position.x = CGFloat(randNum())
        sprite.position.y = CGFloat(randNum())

        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)

        sprite.runAction(SKAction.repeatActionForever(action))

        self.addChild(sprite)
    }

    func randNum() -> UInt! {
        return UInt(CGRectGetMidX(self.frame))
            + UInt(arc4random_uniform(UInt32(self.frame.width * 0.9)))
            - UInt(self.frame.width / 2)
    }
}
