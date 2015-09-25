//
//  Player.swift
//  SG_Template
//
//  Created by Kailash Ramaswamy on 28/06/15.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class Player: Entity {
    
    var playerIndex = 0
    
    var jumpPressedDown = false
    
    var throwPressedDown = false
    
    var health = 1.0
    
    var animJumping:SKAction?
    var animRunning:SKAction?
    var animDying:SKAction?
    var animThrow:SKAction?
    var animJumpThrow:SKAction?
    
    var sndJump:SKAction?
    var sndSht:SKAction?
    
    var isOnGround = true
    var isJumping = false
    var isThrowing = false
    
    var groundY:CGFloat = 0.0
    
    var previousY:CGFloat = 0.0
    
    
    override func update(delta: CFTimeInterval) {
        
        position = position + CGPoint(x: delta * 250, y: 0.0)
        
        if isOnGround == true && jumpPressedDown == true {
            isOnGround = false
            isThrowing = false
            self.removeAllActions()
            self.runAction(animJumping)
            groundY = position.y - 1
            isJumping = true
        }
        
        
            if isJumping == true{
                physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 57.0))
                
                if ((position.y - groundY > 50) || ((position.y <= previousY) && ((position.y  - groundY) > 2))) {
                    isJumping = false
                    self.parent!.runAction(sndJump)
                }
                
            }

    
        if isJumping == false && isOnGround == false && (position.y == previousY){
            isOnGround = true
            removeAllActions()
            isThrowing = false
            runAction(animRunning)
        }
        previousY = position.y
      
        if throwPressedDown && isThrowing == false && ((self.parent?.parent?.parent as! GameScene).layerprojectile.children.count < 3){
             self.parent!.runAction(sndSht)
            isThrowing = true
            self.removeAllActions()
            self.runAction(SKAction.sequence([animThrow!,SKAction.runBlock({ () -> Void in
                let `throw` = ThrowWeapon(entityPosition: CGPoint(x: self.position.x, y: self.position.y - (self.size.height/2)), entitySize: CGSize(width: 50, height: 40), entID: 1)
                let scene = self.parent?.parent?.parent as! GameScene
                scene.layerprojectile.addChild(`throw`)
                self.isThrowing = false
                
            }), animRunning!]))
        }
        
    }

  

    
    override func configureCollisionBody() {
        
         physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width * 0.93, height: size.height * 0.93), center: CGPoint(x: -(self.size.width/2), y: -(self.size.height/2)))
        
        physicsBody?.dynamic = true
            
        physicsBody?.allowsRotation = false
        
        physicsBody?.restitution = 0.0
            
        physicsBody?.angularDamping = 0.0
            
        physicsBody?.linearDamping = 0.0
            
        physicsBody?.friction = 0.0
        
        physicsBody?.affectedByGravity = true
        physicsBody?.categoryBitMask = ColliderType.Player
        physicsBody?.collisionBitMask = ColliderType.Wall | ColliderType.Destroyable
        physicsBody?.contactTestBitMask = ColliderType.Collectible | ColliderType.Trigger
        
    }
    override func buildSprite() {
        if entityID != nil {
            playerIndex = entityID!
        }
        
        if let chars = gameSettings?.objectForKey("GameParams")?.objectForKey("Players") as? Array<NSDictionary>{
            
            let mychar = chars[playerIndex]
            animRunning = prepareAnimationForDictionary(mychar["Anim_Running"] as! NSDictionary, repeated: true)
             animJumping = prepareAnimationForDictionary(mychar["Anim_Jump"] as! NSDictionary, repeated: false)
             animDying = prepareAnimationForDictionary(mychar["Anim_Death"] as! NSDictionary, repeated: false)
             animThrow = prepareAnimationForDictionary(mychar["Anim_Throw"] as! NSDictionary, repeated: false)
            
            sndJump = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false)
            self.runAction(animRunning)
            sndSht = SKAction.playSoundFileNamed("shoot.wav", waitForCompletion: false)
            zPosition = 50
            previousY = position.y
        }
    }
}
