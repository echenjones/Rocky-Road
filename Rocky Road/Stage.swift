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
        
        flower.physicsBody = SKPhysicsBody(texture: flowerTexture, size: flowerTexture.size())
        flower.physicsBody?.isDynamic = false
        flower.physicsBody?.affectedByGravity = false
        
        let distance = CGFloat(2 * self.frame.height + 50)
        let moveFlower = SKAction.moveBy(x: 0, y: -distance, duration: TimeInterval(0.01 * distance))
        let removeFlower = SKAction.removeFromParent()
        let animateFlower = SKAction.sequence([moveFlower, removeFlower])
        flower.run(animateFlower)
        
        return flower
    }
    
    func makeBush(position: CGPoint) -> SKSpriteNode {
        let bushTexture = SKTexture(imageNamed: "bush")
        let bush = SKSpriteNode(texture: bushTexture)
        bush.name = "bush"
        bush.zPosition = 1
        bush.position = position
        bush.setScale(0.35)
        
        bush.physicsBody = SKPhysicsBody(texture: bushTexture, size: bushTexture.size())
        bush.physicsBody?.isDynamic = false
        bush.physicsBody?.affectedByGravity = false
        
        let distance = CGFloat(2 * self.frame.height + 50)
        let moveBush = SKAction.moveBy(x: 0, y: -distance, duration: TimeInterval(0.01 * distance))
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
        let delay = SKAction.wait(forDuration: kNewObstacleInterval)
        let obstacleSequence = SKAction.sequence([spawn, delay])
        let execute = SKAction.repeatForever(obstacleSequence)
        run(execute)
    }
    
    func makeWorld(animate: Bool) {
        /*enumerateChildNodes(withName: "worldLayer") { node, _ in
            if let layer = node as? SKSpriteNode {
                layer.removeFromParent()
            }
        }
        
        for layer in 1...kNumWorldLayers {
            let img = SKTexture(imageNamed: "bg0\(layer)")
            for i in 0...1 {
                let time = Double(layer) * kWorldAnimationFactor
                let node = SKSpriteNode(texture: img)
                node.name = "worldLayer"
                node.anchorPoint = CGPoint.zero
                node.zPosition = CGFloat(layer * -10)
                node.position = CGPoint(x: 0 - node.size.width * CGFloat(i), y: 0 - node.size.height * 1.25)
                addChild(node)
                
                if animate {
                    let moveLeft = SKAction.moveBy(x: -node.size.width, y: 0, duration: time)
                    let reset = SKAction.moveBy(x: node.size.width, y: 0, duration: 0)
                    let sequence = SKAction.sequence([moveLeft, reset])
                    let forever = SKAction.repeatForever(sequence)
                    node.run(forever)
                }
            }
        }*/
        
        enumerateChildNodes(withName: "background") { node, _ in
            if let panel = node as? SKSpriteNode {
                panel.removeFromParent()
            }
        }
        
        let img = SKTexture(imageNamed: "grass-background")
        for i in 0...1 {
            let time = kWorldAnimationFactor
            let node = SKSpriteNode(texture: img)
            node.name = "background"
            node.anchorPoint = CGPoint.zero
            node.zPosition = 0
            node.setScale(0.7)
            node.position = CGPoint(x: 0 - node.size.width * 0.5, y: 0 - node.size.height * CGFloat(i))
            addChild(node)
            
            if animate {
                let moveDown = SKAction.moveBy(x: 0, y: -self.frame.height, duration: time)
                let reset = SKAction.moveBy(x: 0, y: self.frame.height, duration: 0)
                let sequence = SKAction.sequence([moveDown, reset])
                let forever = SKAction.repeatForever(sequence)
                node.run(forever)
            }
        }
    }
    
    func makeRocky() {
        let rockyTexture = SKTexture(imageNamed: "rocky-1")
        rocky = SKSpriteNode(texture: rockyTexture)
        rocky.name = "rocky"
        rocky.zPosition = 9
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
        self.addChild(rocky)
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
}
