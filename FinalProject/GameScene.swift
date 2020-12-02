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


class GameScene: SKScene {
    
    var playerOptional: SKSpriteNode?
    var obstacleOptional: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        playerOptional = self.childNode(withName: "player") as? SKSpriteNode
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
    
    func addObstacle() {
        // pick random obstacle
        obstacleOptional = SKSpriteNode(imageNamed: "cone")
        // add obstacle to scene
        if let obstacle = obstacleOptional {
            obstacle.anchorPoint = CGPoint(x: 1, y: 0)
            obstacle.position = CGPoint(x: frame.maxX, y: -225)
            obstacle.size = CGSize(width: 100, height: 100)
            obstacle.zPosition = CGFloat(1)
            obstacle.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: -25, dy: 0), duration: 0.1)))
//            obstacle.physicsBody = SKPhysicsBody(texture: obstacle.texture!, size: obstacle.texture!.size())
//            obstacle.physicsBody?.affectedByGravity = false
//            obstacle.physicsBody?.allowsRotation = false
            addChild(obstacle)
        }
    }
}
