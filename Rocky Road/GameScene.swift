//
//  GameScene.swift
//  Rocky Road
//
//  Created by Elana Chen-Jones on 11/14/22.
//

import SpriteKit
import GameplayKit

var kNewObstacleInterval: TimeInterval = 5
var kWorldAnimationFactor: Double = 13.5 // speed for background

class GameScene: SKScene {
    
    var gameOne = true
    var gameOver = true
    var chooseLevel = false
    var rocky = SKSpriteNode()
    var flower = SKNode()
    var bush = SKNode()
    var level = 0
    var level1Btn = SKSpriteNode()
    var level2Btn = SKSpriteNode()
    var level3Btn = SKSpriteNode()
    var startBtn = SKSpriteNode()
    var restartBtn = SKSpriteNode()
    var leftBtn = SKSpriteNode()
    var rightBtn = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var score = 0 {
        didSet {
            scoreLabel.text = score.description
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameOver == true {
            for touch in touches {
                let location = touch.location(in: self)
                if chooseLevel == true {
                    for touch in touches {
                        let location = touch.location(in: self)
                        if level1Btn.contains(location) {
                            //level = 1
                            kNewObstacleInterval = 4
                            kWorldAnimationFactor = 13 // speed for background
                            startGame()
                        }
                        else if level2Btn.contains(location) {
                            //level = 2
                            kNewObstacleInterval = 3
                            kWorldAnimationFactor = 11 // speed for background
                            startGame()
                        }
                        else if level3Btn.contains(location) {
                            //level = 3
                            kNewObstacleInterval = 2
                            kWorldAnimationFactor = 9 // speed for background
                            startGame()
                        }
                        
                    }
                }
                else if startBtn.contains(location) || restartBtn.contains(location) {
                    getLevel()
                }
            }
        }
        else {
            for touch in touches {
                let location = touch.location(in: self)
                let column1 = 0 - self.frame.width * 0.25
                let column2 = 0
                let column3 = self.frame.width * 0.25
                var newPos: CGPoint
                if leftBtn.contains(location) {
                    if (rocky.position.x > column3 - 2) {
                        newPos = CGPoint(x: column2, y: 0 - Int(self.frame.height * 0.2))
                    }
                    else {
                        newPos = CGPoint(x: column1, y: 0 - CGFloat(self.frame.height * 0.2))
                    }
                    rocky.run(SKAction.move(to: newPos, duration: 0.15))
                }
                else if rightBtn.contains(location) {
                    if (rocky.position.x < column1 + 2) {
                        newPos = CGPoint(x: column2, y: 0 - Int(self.frame.height * 0.2))
                    }
                    else {
                        newPos = CGPoint(x: column3, y: 0 - CGFloat(self.frame.height * 0.2))
                    }
                    rocky.run(SKAction.move(to: newPos, duration: 0.15))
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        makeScoreLabel()
        makeWorld(animate: false)
        standby()
        physicsWorld.contactDelegate = self
    }
    
    func getLevel() {
        startBtn.removeFromParent()
        restartBtn.removeFromParent()
        makeLevel1Btn()
        makeLevel2Btn()
        makeLevel3Btn()
    }
    
    func startGame() {
        score = 0
        gameOver = false
        chooseLevel = false
        level1Btn.removeFromParent()
        level2Btn.removeFromParent()
        level3Btn.removeFromParent()
        makeLeftBtn()
        makeRightBtn()
        makeWorld(animate: true)
        makeRocky()
        startRunningObstacles()
    }
    
    func stopGame() {
        gameOver = true
        removeAllActions()
        gameOne = false
        self.standby()
    }
    
    func standby() {
        if gameOne {
            makeStartBtn()
        }
        else {
            makeRestartBtn()
        }
    }
    
    //var music = SKAudioNode(url: Bundle.main.url(forResource: "winds-of-story", withExtension: "mp3")!)
    //let sndCollect = SKAction.playSoundFileNamed("ding", waitForCompletion: false)
    //let sndSplat = SKAction.playSoundFileNamed("radar_fail.wav", waitForCompletion: false)
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "flower" || contact.bodyB.node?.name == "flower" {
            if contact.bodyA.node == rocky {
                contact.bodyB.node?.removeFromParent()
            }
            else {
                contact.bodyA.node?.removeFromParent()
            }
            //run(sndCollect)
            score += 1
        }
        else if contact.bodyA.node?.name == "bush" || contact.bodyB.node?.name == "bush" {
            rocky.removeAllActions()
            rocky.texture = SKTexture(imageNamed: "winter-rocky-crash")
            stopGame()
        }
    }
}
