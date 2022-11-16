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
    
    var gameOne = true
    var gameOver = true
    var rocky = SKSpriteNode()
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
                }
                else if rightBtn.contains(location) {
                    // if not in column 3 -> move rocky right 1 column
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
        makeScoreLabel()
    }
    
    func stopGame() {
        gameOver = true
        removeAllActions()
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
    //let sndSplate = SKAction.playSoundFileNamed("radar_fail.wav", waitForCompletion: false)
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
