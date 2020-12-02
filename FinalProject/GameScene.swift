//
//  GameScene.swift
//  FinalProject
//
//  Created by Kierin Noreen on 11/29/20.
//  Copyright © 2020 Kierin Noreen. All rights reserved.
//

import SpriteKit
import GameplayKit

// author credit for skater image: <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for cone image: <div>Icons made by <a href="http://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for garbage image: <div>Icons made by <a href="http://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for dollar image: <div>Icons made by <a href="https://www.flaticon.com/free-icon/dollar_770062?related_item_id=770045&term=dollar%20bill" title="Good Ware">Good Ware</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for city image: <div>Icons made by <a href="https://www.flaticon.com/authors/smalllikeart" title="smalllikeart">smalllikeart</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for hole image: <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>

struct PhysicsCategory {
    static let player: UInt32 = 0x1 << 0
    static let obstacle: UInt32 = 0x1 << 1
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var playerOptional: SKSpriteNode?
    var obstacleOptional: SKSpriteNode?
    var viewControllerOptional: UIViewController?
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        playerOptional = self.childNode(withName: "player") as? SKSpriteNode
        if let player = playerOptional {
            player.physicsBody?.categoryBitMask = PhysicsCategory.player
            player.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        }
        addObstacle()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let player = playerOptional, player.position.y <= -130 {
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 325))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if firstBody.categoryBitMask == PhysicsCategory.player && secondBody.categoryBitMask == PhysicsCategory.obstacle {
            // player hit obstacle - game over
            self.isPaused = true
            let alertController = UIAlertController(title: "Game Over", message: "You hit an obstacle!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            if let viewController = viewControllerOptional {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func addObstacle() {
        // pick random obstacle
        obstacleOptional = SKSpriteNode(imageNamed: "cone")
        // add obstacle to scene
        if let obstacle = obstacleOptional {
            obstacle.anchorPoint = CGPoint(x: 0, y: 0)
            obstacle.position = CGPoint(x: frame.maxX, y: -225)
            obstacle.size = CGSize(width: 100, height: 100)
            obstacle.zPosition = CGFloat(1)
            obstacle.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: -25, dy: 0), duration: 0.1)))
            obstacle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle.size.width, height: obstacle.size.height), center: CGPoint(x: obstacle.size.width / 2, y: obstacle.size.height / 2))
            obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
            obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.player
            addChild(obstacle)
        }
    }
}
