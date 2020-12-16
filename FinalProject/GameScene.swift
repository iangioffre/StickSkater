//
//  GameScene.swift
//  FinalProject
//
//  Created by Kierin Noreen, Ian Gioffre on 11/29/20.
//  Copyright © 2020 Kierin Noreen. All rights reserved.
//

import SpriteKit
import GameplayKit

// author credit for background.png: Emmett Zinda

// author credit for skater image: <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for cone image: <div>Icons made by <a href="http://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for garbage image: <div>Icons made by <a href="http://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for dollar image: <div>Icons made by <a href="https://www.flaticon.com/free-icon/dollar_770062?related_item_id=770045&term=dollar%20bill" title="Good Ware">Good Ware</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for city image: <div>Icons made by <a href="https://www.flaticon.com/authors/smalllikeart" title="smalllikeart">smalllikeart</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>

enum PhysicsCategory: UInt32 {
    case skater = 1
    case obstacle = 2
    case road = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewControllerOptional: UIViewController?
    
    var skater = SKSpriteNode()
    var background = SKSpriteNode()
    var road = SKSpriteNode()
    var obstacle = SKSpriteNode()
    var play = SKLabelNode()
    
    var gameTimer: Timer?
    var possibleObstacles = ["garbage", "cone", "hole"]
    var gameEnded = false
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        setupSprites()
        self.isPaused = true
        
//        playerOptional = self.childNode(withName: "player") as? SKSpriteNode
//        if let player = playerOptional {
//            player.physicsBody?.categoryBitMask = PhysicsCategory.player
//            player.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
//        }
    }
    
    func setupSprites() {
        // background
        background = SKSpriteNode(imageNamed: "background")
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = -2
        addChild(background)
        
        // road (floor)
//        road = SKSpriteNode(imageNamed: "road")
//        road.size = CGSize(width: self.frame.width, height: ROAD_HEIGHT)
        road = SKSpriteNode(color: .gray, size: CGSize(width: self.frame.width, height: 150))
        road.position = CGPoint(x: self.frame.midX, y: self.frame.minY + road.size.height / 2)
        road.zPosition = -1
        road.physicsBody = SKPhysicsBody(rectangleOf: road.size)
        road.physicsBody?.isDynamic = false
        road.physicsBody?.categoryBitMask = PhysicsCategory.road.rawValue
        road.physicsBody?.restitution = 0
        addChild(road)
        
        // skater (player)
        skater = SKSpriteNode(imageNamed: "skater")
        skater.size = CGSize(width: 160, height: 180)
        skater.position = CGPoint(x: self.frame.minX + 200, y: road.position.y + (road.size.height / 2) + (skater.size.height / 2))
        skater.physicsBody = SKPhysicsBody(texture: skater.texture!, size: skater.size)
        skater.physicsBody?.categoryBitMask = PhysicsCategory.skater.rawValue
        skater.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle.rawValue
        skater.physicsBody?.collisionBitMask = PhysicsCategory.road.rawValue
        skater.physicsBody?.restitution = 0
        skater.physicsBody?.allowsRotation = false
        addChild(skater)
        
        // obstacles
        addObstacle()
        
        // buildings
        
        
        // play button
        play.fontSize = 100
        play.fontName = "AvenirNext-Bold"
        play.fontColor = .black
        play.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        play.text = "Tap to Play"
        addChild(play)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isPaused {
            self.removeAllChildren()
            setupSprites()
            play.isHidden = true
            self.isPaused = false
        } else {
            let skaterGroundPosition = road.position.y + (road.size.height / 2) + (skater.size.height / 2) + 5
            if skater.position.y <= skaterGroundPosition {
                skater.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.obstacle.rawValue || contact.bodyB.categoryBitMask == PhysicsCategory.obstacle.rawValue {
            // obstacle has been contacted by skater
            self.isPaused = true
//            let alertController = UIAlertController(title: "Game Over", message: "You hit an obstacle!", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
//            if let viewController = viewControllerOptional {
//                viewController.present(alertController, animated: true, completion: nil)
//            }
            play.isHidden = false
        }
    }
    
    func addObstacle() {
        // pick random obstacle
        obstacle = SKSpriteNode(imageNamed: "cone")
        // add obstacle to scene
        obstacle.size = CGSize(width: 100, height: 100)
        obstacle.position = CGPoint(x: self.frame.maxX + obstacle.size.width / 2, y: road.position.y + (road.size.height / 2) + 50)
        obstacle.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: -35, dy: 0), duration: 0.1)))
        obstacle.physicsBody = SKPhysicsBody(texture: obstacle.texture!, size: obstacle.size)
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.physicsBody?.allowsRotation = false
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle.rawValue
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.skater.rawValue
        addChild(obstacle)
    }
}
