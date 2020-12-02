//
//  GameScene.swift
//  FinalProject
//
//  Created by Kierin Noreen on 11/29/20.
//  Copyright © 2020 Kierin Noreen. All rights reserved.
//

import SpriteKit
import GameplayKit

//author credit for skater image: <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
//author credit for road image: <div>Icons made by <a href="https://www.flaticon.com/free-icon/road_3754375?related_item_id=3755442&term=city%20streets" title="iconixar">iconixar</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for cone image: <div>Icons made by <a href="http://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for bench image: <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for dollar image: <div>Icons made by <a href="https://www.flaticon.com/authors/good-ware" title="Good Ware">Good Ware</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// author credit for city image: <div>Icons made by <a href="https://www.flaticon.com/authors/smalllikeart" title="smalllikeart">smalllikeart</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>


class GameScene: SKScene {
    
    var playerOptional: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        playerOptional = self.childNode(withName: "player") as? SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let player = playerOptional, player.position.y <= -130 {
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 325))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
