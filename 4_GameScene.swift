//
//  4_GameScene.swift
//  SG_Template
//
//  Created by Kailash Ramaswamy on 27/06/15.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class GameScene: SGScene, SKPhysicsContactDelegate {
    
    enum gameState {
        case gamePreGame
        case gamePaused
        case gameActive
        case gameDeath
    }
    
    var ninjaIndex:Int = 0
    
    var currentlevel:String?
    
    var currentGameState:gameState = gameState.gameActive
    var lastupdatetime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    
    var playerNinja:Player?
    
    var bg1static = SKNode()
    var bg2slow = LayerBackground()
    var bg3fast = LayerBackground()
    var gameWorld: LayerWorld?
    var layerprojectile = LayerProjectiles()
    var layerCharacter = SKNode()
    
    var layerhud = layerHUD()
    var gemsCollected = 0
    
    let sndCollect = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        assignLayers()
        setupLayers()
        
        physicsWorld.contactDelegate = self
    }
    
    func assignLayers(){
        addChild(bg1static)
        addChild(bg2slow)
        bg2slow.layerVelocity = CGPoint(x: -100.0, y: 0.0)
        addChild(bg3fast)
        bg3fast.layerVelocity = CGPoint(x: -175.0, y: 0.0)
        gameWorld = tileMapLayerFromFileNamed(currentlevel!)
        if gameWorld != nil {
            gameWorld?.layerVelocity = CGPoint(x: -250.0, y: 0.0)
            
            addChild(gameWorld!)
            
            gameWorld!.addChild(layerCharacter)
            gameWorld?.addChild(layerprojectile)
        }
        addChild(layerhud)
    }
    
    func setupLayers(){
        
        let background = SKSpriteNode(imageNamed: "BG001")
        background.posByCanvas(0.5, y: 0.5)
        background.zPosition = -1
        bg1static.addChild(background)
        
        let background2 = SKSpriteNode(imageNamed: "BG002")
        background2.posByCanvas(0.0, y: 0.0)
        background2.anchorPoint = CGPointZero
        background2.zPosition = 1
        background2.name = "A"
        bg2slow.addChild(background2)
        
        let background3 = SKSpriteNode(imageNamed: "BG002")
        background3.posByCanvas(1.0, y: 0.0)
        background3.anchorPoint = CGPointZero
        background3.zPosition = 1
        background3.name = "B"
        bg2slow.addChild(background3)
        
        let background4 = SKSpriteNode(imageNamed: "BG003")
        background4.position = CGPointZero
        background4.anchorPoint = CGPointZero
        background4.zPosition = 2
        background4.name = "A"
        bg3fast.addChild(background4)
        
        let background5 = SKSpriteNode(imageNamed: "BG003")
        background5.posByCanvas(1.0, y: 0.0)
        background5.anchorPoint = CGPointZero
        background5.zPosition = 2
        background5.name = "B"
        bg3fast.addChild(background5)
        
        playerNinja = Player(entityPosition: CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.4), entitySize: CGSize(width: 123.75, height: 134.0), entID: ninjaIndex)
        playerNinja?.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        layerCharacter.addChild(playerNinja!)
    }
    override func screenInteractionStarted(location: CGPoint) {
        if (location.x < (self.size.width/2)) && (location.y < (self.size.height/2)) {
            playerNinja?.throwPressedDown = true
        }
        if (location.x > (self.size.width/2)) && (location.y < (self.size.height/2)) {
            playerNinja?.jumpPressedDown = true
        }
        if (location.x > (self.size.width * 0.75)) && (location.y > (self.size.height * 0.75)) {
            if currentGameState == .gameActive {
                currentGameState = .gamePaused
                physicsWorld.speed = 0.0
                speed = 0.0
            } else {
                currentGameState = .gameActive
                physicsWorld.speed = 1.0
                speed = 1.0
                
            }
        }
    }
    
    override func screenInteractionMoved(location: CGPoint) {
        playerNinja?.jumpPressedDown = false
        playerNinja?.throwPressedDown = false
    }
    
    override func screenInteractionEnded(location: CGPoint) {
        playerNinja?.jumpPressedDown = false
        playerNinja?.throwPressedDown = false
    }
    
    #if !os(iOS)
    
    override func handleKeyEvent(event: NSEvent, keyDown: Bool) {
    for scalar in event.characters! {
    switch scalar {
    case "x" where keyDown:
    playerNinja?.jumpPressedDown = true
    break
    case "z" where keyDown:
    playerNinja?.throwPressedDown = true
    break
    case "p" where keyDown:
    if currentGameState == .gameActive {
    currentGameState = .gamePaused
    physicsWorld.speed = 0.0
    speed = 0.0
    } else {
    currentGameState = .gameActive
    physicsWorld.speed = 1.0
    speed = 1.0
    
    }
    break
    default:
    playerNinja?.jumpPressedDown = false
    playerNinja?.throwPressedDown = false
    break
    }
    }
}
    
    #endif
    
    override func update(currentTime: NSTimeInterval) {
        
        if lastupdatetime > 0 {
            dt = currentTime - lastupdatetime
        } else {
            dt = 0
        }
        lastupdatetime = currentTime
        
        if currentGameState == gameState.gameActive {
            
            bg2slow.update(dt, affectAllNodes: true, parallax: true)
            
             bg3fast.update(dt, affectAllNodes: true, parallax: true)
            
            gameWorld?.update(dt, affectAllNodes: true, parallax: true)
            
            playerNinja?.update(dt)
            
            if playerNinja!.position.x < ((layerCharacter.position.x * -1) + 60) || playerNinja!.position.y < -30 {
                currentGameState = .gameDeath
                playerDied()
            }
            
            layerprojectile.update(dt, affectAllNodes: true, parallax: true)
            
            layerhud.update(dt)
        }
    }
    func didBeginContact(contact: SKPhysicsContact) {
        if let node1 = contact.bodyA.node{
            let entityNode = node1 as! Entity
            entityNode.collidedWith(contact.bodyB, contact: contact)
        }
        if let node2 = contact.bodyB.node{
            let entityNode = node2 as! Entity
            entityNode.collidedWith(contact.bodyA, contact: contact)
        }
    }
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    func triggerWithCommand(command:String) {
        
        switch command {
        case "finish-level":
            
            let post = PostScreen(size: scene!.size)
            
            post.level = currentlevel
            post.win = true
            post.gems = gemsCollected
            
            post.scaleMode = scaleMode
            let transition = SKTransition.fadeWithDuration(0.6)
            view?.presentScene(post, transition: transition)
            
        case "add-gem":
            self.runAction(sndCollect)
            gemsCollected++
            
        default:
            break
        }
        
    }
    
    func playerDied() {
        let post = PostScreen(size: scene!.size)
//        post.level = currentLevel
        post.win = false
        post.gems = gemsCollected
        post.scaleMode = self.scaleMode
        let transition = SKTransition.fadeWithDuration(0.6)
        view?.presentScene(post, transition: transition)
    }
    
}
