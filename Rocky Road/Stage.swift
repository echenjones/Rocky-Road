//
//  Stage.swift
//  Rocky Road
//
//  Created by Elana Chen-Jones on 11/15/22.
//

import SpriteKit

extension GameScene {
    
    func makeFlower(position: CGPoint) {
        let flowerTexture = SKTexture(imageNamed: "dandelion")
        let flower = SKSpriteNode(texture: flowerTexture)
        flower.name = "flower"
        flower.zPosition = 1
        flower.position = position
        
        flower.physicsBody = SKPhysicsBody(texture: flowerTexture, size: flowerTexture.size())
        flower.physicsBody?.isDynamic = false
        flower.physicsBody?.affectedByGravity = false
        
        let distance = CGFloat(self.frame.height + 50)
        let moveFlower = SKAction.moveBy(x: 0, y: -distance, duration: TimeInterval(0.01 * distance))
        let removeFlower = SKAction.removeFromParent()
        let animateFlower = SKAction.sequence([moveFlower, removeFlower])
        bush.run(animateFlower)
        
        self.addChild(self.flower)
    }
    
    func makeBush(position: CGPoint) {
        let bushTexture = SKTexture(imageNamed: "bush")
        let bush = SKSpriteNode(texture: bushTexture)
        bush.name = "bush"
        bush.zPosition = 1
        bush.position = position
        
        bush.physicsBody = SKPhysicsBody(texture: bushTexture, size: bushTexture.size())
        bush.physicsBody?.isDynamic = false
        bush.physicsBody?.affectedByGravity = false
        
        let distance = CGFloat(self.frame.height + 50)
        let moveBush = SKAction.moveBy(x: 0, y: -distance, duration: TimeInterval(0.01 * distance))
        let removeBush = SKAction.removeFromParent()
        let animateBush = SKAction.sequence([moveBush, removeBush])
        bush.run(animateBush)
        
        self.addChild(self.bush)
    }
    
    func startRunningObstacles() {
        let spawn = SKAction.run {
            let columnNum = CGFloat.random(in: 1...3)
            let columnWidth = (self.frame.width - 40) / 3 // change 40 if border is more/less
            let obstaclePosition: CGPoint
            if columnNum == 1 {
                obstaclePosition = CGPoint(x: 0.5 * columnWidth + 20, y: self.frame.height + 50) // change 20 if border is more/less
            }
            else if columnNum == 2 {
                obstaclePosition = CGPoint(x: self.frame.width / 2, y: self.frame.height + 50)
            }
            else {
                obstaclePosition = CGPoint(x: 2.5 * columnWidth + 20, y: self.frame.height + 50) // change 20 if border is more/less
            }
            
            let obstacleNum = CGFloat.random(in: 1...2)
            if obstacleNum == 1 {
                self.makeFlower(position: obstaclePosition)
            }
            else {
                self.makeBush(position: obstaclePosition)
            }
        }
        let delay = SKAction.wait(forDuration: kNewObstacleInterval)
        let obstacleSequence = SKAction.sequence([spawn, delay])
        let execute = SKAction.repeatForever(obstacleSequence)
        run(execute)
    }
    
    func makeRocky() -> SKSpriteNode {
        let rockyTexture = SKTexture(imageNamed: "rocky-1")
        rocky = SKSpriteNode(texture: rockyTexture)
        rocky.name = "rocky"
        rocky.zPosition = 10
        rocky.position = CGPoint(x: 0, y: 0 - frame.height * 0.2)
        rocky.setScale(0.35)

        rocky.physicsBody = SKPhysicsBody(texture: rockyTexture, size: rockyTexture.size())
        rocky.physicsBody?.contactTestBitMask = rocky.physicsBody!.collisionBitMask
        rocky.physicsBody?.isDynamic = true
        rocky.physicsBody?.allowsRotation = false
        rocky.physicsBody?.affectedByGravity = false

        let anim = SKAction.animate(with: [
            SKTexture(imageNamed: "rocky-1"),
            SKTexture(imageNamed: "rocky-2"),], timePerFrame: 0.1)
        let forever = SKAction.repeatForever(anim)
        rocky.run(forever)
        addChild(rocky)
        return rocky
    }
    
    func makeStartBtn() {
        startBtn = SKSpriteNode(imageNamed: "button-start")
        startBtn.position = CGPoint(x: 0, y: 0)
        startBtn.zPosition = 10
        startBtn.setScale(0)
        startBtn.run(SKAction.scale(to: 0.8, duration: 0.6))
        self.addChild(startBtn)
    }
    
    func makeRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "button-restart")
        restartBtn.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        restartBtn.zPosition = 10
        restartBtn.setScale(0)
        restartBtn.run(SKAction.scale(to: 0.8, duration: 0.6))
        self.addChild(restartBtn)
    }
    
    func makeLeftBtn() {
        leftBtn = SKSpriteNode(imageNamed: "button-left")
        leftBtn.position = CGPoint(x: 0 - self.frame.width * 0.25, y: 0 - self.frame.height * 0.4)
        leftBtn.zPosition = 10
        leftBtn.setScale(0)
        leftBtn.run(SKAction.scale(to: 0.3, duration: 0.25))
        self.addChild(leftBtn)
    }
    
    func makeRightBtn() {
        rightBtn = SKSpriteNode(imageNamed: "button-right")
        rightBtn.position = CGPoint(x: self.frame.width * 0.25, y: 0 - self.frame.height * 0.4)
        rightBtn.zPosition = 10
        rightBtn.setScale(0)
        rightBtn.run(SKAction.scale(to: 0.3, duration: 0.25))
        self.addChild(rightBtn)
    }
    
    func makeScoreLabel() {
        scoreLabel = SKLabelNode()
        scoreLabel.position = CGPoint(x: self.frame.width * 0.25, y: self.frame.height * 0.4)
        scoreLabel.fontName = "PressStart2P"
        scoreLabel.fontColor = UIColor.systemOrange
        scoreLabel.fontSize = 52
        scoreLabel.zPosition = 10
        scoreLabel.run(SKAction.scale(to: 1.0, duration: 0.25))
        addChild(scoreLabel)
    }
}
