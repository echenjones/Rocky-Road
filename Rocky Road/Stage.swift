//
//  Stage.swift
//  Rocky Road
//
//  Created by Elana Chen-Jones on 11/15/22.
//

import SpriteKit

extension GameScene {
    
    func makeFlower(position: CGPoint) -> SKSpriteNode {
        let flowerTexture = SKTexture(imageNamed: "dandelion")
        let flower = SKSpriteNode(texture: flowerTexture)
        flower.name = "flower"
        flower.zPosition = 1
        flower.position = position
        flower.setScale(0.3)
        
        flower.physicsBody = SKPhysicsBody(texture: flowerTexture, size: flower.size)
        flower.physicsBody?.isDynamic = false
        flower.physicsBody?.affectedByGravity = false
        
        let distance = CGFloat(2 * self.frame.height + 50)
        let moveFlower = SKAction.moveBy(x: 0, y: -distance, duration: distance / self.frame.height * kWorldAnimationFactor)
        let removeFlower = SKAction.removeFromParent()
        let animateFlower = SKAction.sequence([moveFlower, removeFlower])
        flower.run(animateFlower)
        
        return flower
    }
    
    func makeBush(position: CGPoint) -> SKSpriteNode {
        let bushTexture = SKTexture(imageNamed: "bush" + String(Int.random(in: 1...2)))
        let bush = SKSpriteNode(texture: bushTexture)
        bush.name = "bush"
        bush.zPosition = 1
        bush.position = position
        bush.setScale(0.15)
        
        bush.physicsBody = SKPhysicsBody(texture: bushTexture, size: bush.size)
        bush.physicsBody?.isDynamic = false
        bush.physicsBody?.affectedByGravity = false
        
        let distance = CGFloat(2 * self.frame.height + 50)
        let moveBush = SKAction.moveBy(x: 0, y: -distance, duration: distance / self.frame.height * kWorldAnimationFactor)
        let removeBush = SKAction.removeFromParent()
        let animateBush = SKAction.sequence([moveBush, removeBush])
        bush.run(animateBush)
        
        return bush
    }
    
    func startRunningObstacles() {
        let spawn = SKAction.run {
            let columnNum = CGFloat.random(in: -75...75)
            let obstaclePosition: CGPoint
            if columnNum < -25 {
                obstaclePosition = CGPoint(x: 0 - self.frame.width * 0.275, y: self.frame.height)
            }
            else if columnNum >= -25 && columnNum <= 25 {
                obstaclePosition = CGPoint(x: 0, y: self.frame.height)
            }
            else {
                obstaclePosition = CGPoint(x: self.frame.width * 0.275, y: self.frame.height)
            }
            
            let obstacle: SKSpriteNode
            let obstacleNum = CGFloat.random(in: -50...50)
            if obstacleNum <= 0 {
                obstacle = self.makeFlower(position: obstaclePosition)
            }
            else {
                obstacle = self.makeBush(position: obstaclePosition)
            }
            self.addChild(obstacle)
        }
        let delay = SKAction.wait(forDuration: kNewObstacleInterval, withRange: 2)
        let obstacleSequence = SKAction.sequence([spawn, delay])
        let execute = SKAction.repeatForever(obstacleSequence)
        run(execute)
    }
    
    func makeWorld(animate: Bool) {
        
        let img = SKTexture(imageNamed: "background")
        
        for i in 0...1 {
            let time = kWorldAnimationFactor
            let node = SKSpriteNode(texture: img)
            node.name = "background"
            // node.anchorPoint = CGPoint.zero
            node.zPosition = 0
            node.setScale(0.9)
            node.position = CGPoint(x: 0, y: node.frame.height * CGFloat(i))
            addChild(node)
            
            let moveDown = SKAction.moveBy(x: 0, y: -node.frame.height, duration: node.frame.height / self.frame.height * time)
            let reset = SKAction.moveBy(x: 0, y: node.frame.height, duration: 0)
            let sequence = SKAction.sequence([moveDown, reset])
            let forever = SKAction.repeatForever(sequence)
            
            if animate {
                node.run(forever)
            }
        }
    }
    
    func makeRocky() {
        let rockyTexture = SKTexture(imageNamed: "wasp-1")
        rocky = SKSpriteNode(texture: rockyTexture)
        rocky.name = "rocky"
        rocky.zPosition = 9
        rocky.position = CGPoint(x: 0, y: 0 - frame.height * 0.2)
        rocky.setScale(0.35)

        rocky.physicsBody = SKPhysicsBody(texture: rockyTexture, size: rocky.size)
        rocky.physicsBody?.contactTestBitMask = rocky.physicsBody!.collisionBitMask
        rocky.physicsBody?.isDynamic = true
        rocky.physicsBody?.allowsRotation = false
        rocky.physicsBody?.affectedByGravity = false

        let anim = SKAction.animate(with: [
            SKTexture(imageNamed: "wasp-1"),
            SKTexture(imageNamed: "wasp-2"),], timePerFrame: 0.1)
        let forever = SKAction.repeatForever(anim)
        rocky.run(forever)
        self.addChild(rocky)
    }
    
    func makeStartBtn() {
        startBtn = SKSpriteNode(imageNamed: "button-start")
        startBtn.name = "startButton"
        startBtn.position = CGPoint(x: 0, y: 0)
        startBtn.zPosition = 10
        startBtn.setScale(0)
        startBtn.run(SKAction.scale(to: 0.8, duration: 0.6))
        self.addChild(startBtn)
    }
    
    func makeRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "button-restart")
        restartBtn.name = "startButton"
        restartBtn.position = CGPoint(x: 0, y: 0)
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
        self.addChild(scoreLabel)
    }
    
    func makeLevel1Btn() {
        level1Btn = SKSpriteNode(imageNamed: "level1")
        level1Btn.name = "levelButton"
        level1Btn.setScale(0.3)
        level1Btn.position = CGPoint(x: 0, y: 0 + level1Btn.frame.height + 20)
        level1Btn.zPosition = 10
        level1Btn.run(SKAction.scale(to: 0.3, duration: 0.25))
        self.addChild(level1Btn)
    }
    
    func makeLevel2Btn() {
        level2Btn = SKSpriteNode(imageNamed: "level2")
        level2Btn.name = "levelButton"
        level2Btn.setScale(0.3)
        level2Btn.position = CGPoint(x: 0, y: 0)
        level2Btn.zPosition = 10
        level2Btn.run(SKAction.scale(to: 0.3, duration: 0.25))
        self.addChild(level2Btn)
    }
    
    func makeLevel3Btn() {
        level3Btn = SKSpriteNode(imageNamed: "level3")
        level3Btn.name = "levelButton"
        level3Btn.setScale(0.3)
        level3Btn.position = CGPoint(x: 0, y: 0 - level3Btn.frame.height - 20)
        level3Btn.zPosition = 10
        level3Btn.run(SKAction.scale(to: 0.3, duration: 0.25))
        self.addChild(level3Btn)
    }
    
}
