//
//  GameScene.swift
//  Rocky Road
//
//  Created by Elana Chen-Jones on 11/14/22.
//

import SpriteKit
import GameplayKit

let kNewObstacleInterval: TimeInterval = 3

class GameScene: SKScene {
    
    //private var label : SKLabelNode?
    //private var spinnyNode : SKShapeNode?
    var gameOne = true
    var gameOver = true
    var wasp = SKSpriteNode()
    var flower = SKNode()
    var bush = SKNode()
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
                if startBtn.contains(location) || restartBtn.contains(location) {
                    startGame()
                }
            }
        }
        else {
            for touch in touches {
                let location = touch.location(in: self)
                if leftBtn.contains(location) {
                    // if not in column 1 -> move rocky left 1 column
                    if (wasp.position.x >= -0.1) {
                        let newPos = CGPoint(x: wasp.position.x - self.frame.width * 0.25, y: 0 - frame.height * 0.1)
                        wasp.run(SKAction.move(to: newPos, duration: 0.15))
                    }
                }
                else if rightBtn.contains(location) {
                    // if not in column 3 -> move rocky right 1 column
                    if (wasp.position.x <= 0.1) {
                        let newPos = CGPoint(x: wasp.position.x + self.frame.width * 0.25, y: 0 - frame.height * 0.1)
                        wasp.run(SKAction.move(to: newPos, duration: 0.15))
                    }
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        makeScoreLabel()
        standby()
    }
    
    func startGame() {
        score = 0
        gameOver = false
        startBtn.removeFromParent()
        restartBtn.removeFromParent()
        makeLeftBtn()
        makeRightBtn()
        wasp = makeWasp()
        makeScoreLabel()
    }
    
    func stopGame() {
        gameOver = true
        removeAllActions()
    }
    
    func standby() {
        makeStartBtn()
    }
    
    //var music = SKAudioNode(url: Bundle.main.url(forResource: "winds-of-story", withExtension: "mp3")!)
    //let sndCollect = SKAction.playSoundFileNamed("ding", waitForCompletion: false)
    //let sndSplate = SKAction.playSoundFileNamed("radar_fail.wav", waitForCompletion: false)
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
