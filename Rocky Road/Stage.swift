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
            let col1 = 0 - self.frame.width * 0.25
            let col3 = 0 + self.frame.width * 0.25
            let obstaclePosition: CGPoint
            // randomize column
            if columnNum == 1 {
                obstaclePosition = CGPoint(x: col1, y: self.frame.height * 0.3)
            }
            else if columnNum == 2 {
                obstaclePosition = CGPoint(x: 0, y: self.frame.height * 0.3)
            }
            else {
                obstaclePosition = CGPoint(x: col3, y: self.frame.height * 0.3)
            }
            // randomize obstacle
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
    
    func makeWasp() -> SKSpriteNode {
        
        let waspTexture = SKTexture(imageNamed: "wasp_1")
        wasp = SKSpriteNode(texture: waspTexture)
        wasp.name = "wasp"
        wasp.zPosition = 10
        wasp.position = CGPoint(x: 0, y: 0 - frame.height * 0.1)
        wasp.setScale(0.35)

        wasp.physicsBody = SKPhysicsBody(texture: waspTexture, size: waspTexture.size())
        wasp.physicsBody?.contactTestBitMask = wasp.physicsBody!.collisionBitMask
        wasp.physicsBody?.isDynamic = true
        wasp.physicsBody?.allowsRotation = false
        wasp.physicsBody?.affectedByGravity = false

        let anim = SKAction.animate(with: [
            SKTexture(imageNamed: "wasp_1"),
            SKTexture(imageNamed: "wasp_2"),], timePerFrame: 0.1)
        let forever = SKAction.repeatForever(anim)
        wasp.run(forever)
        addChild(wasp)
        return wasp
    }
    
    func makeStartBtn() {
        startBtn = SKSpriteNode(imageNamed: "button_start")
        //startBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        startBtn.position = CGPoint(x: 0, y: 0)
        startBtn.zPosition = 10
        startBtn.setScale(0)
        startBtn.run(SKAction.scale(to: 0.8, duration: 0.7))
        self.addChild(startBtn)
    }
    
    func makeRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "button_restart")
        //restartBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        restartBtn.position = CGPoint(x: 0, y: 0)
        restartBtn.zPosition = 10
        restartBtn.setScale(0)
        restartBtn.run(SKAction.scale(to: 0.8, duration: 0.7))
        self.addChild(restartBtn)
    }
    
    func makeLeftBtn() {
        leftBtn = SKSpriteNode(imageNamed: "button_left")
        //leftBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftBtn.position = CGPoint(x: 0 - self.frame.width * 0.25, y: 0 - self.frame.height * 0.4)
        leftBtn.zPosition = 10
        leftBtn.setScale(0)
        leftBtn.run(SKAction.scale(to: 0.3, duration: 0.7))
        self.addChild(leftBtn)
    }
    
    func makeRightBtn() {
        rightBtn = SKSpriteNode(imageNamed: "button_right")
        //rightBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightBtn.position = CGPoint(x: 0 + self.frame.width * 0.25, y: 0 - self.frame.height * 0.4)
        rightBtn.zPosition = 10
        rightBtn.setScale(0)
        rightBtn.run(SKAction.scale(to: 0.3, duration: 0.7))
        self.addChild(rightBtn)
    }
    
    func makeScoreLabel() {
        scoreLabel = SKLabelNode()
        scoreLabel.position = CGPoint(x: 0 - self.frame.width * 0.25, y: self.frame.height * 0.4)
        scoreLabel.fontName = "Marker Felt Wide"
        scoreLabel.fontColor = UIColor.systemOrange
        scoreLabel.fontSize = 52
        scoreLabel.zPosition = 10
        scoreLabel.run(SKAction.scale(to: 1.0, duration: 0.7))
        addChild(scoreLabel)
    }
}
