//
//  1_MainMenu.swift
//  SG_Template
//
//  Created by Kailash Ramaswamy on 27/06/15.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

#if !os(iOS)
    import AppKit
#endif


class MainMenu: SGScene {
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "BG")
        background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1.2
        background.yScale = 1.2
        background.zPosition = -1
        
        addChild(background)
       
        
        let playbutton = SKLabelNode(fontNamed: "DamascusBold")
        playbutton.posByScreen(0.5, y: 0.5)
        playbutton.fontSize = 56
        playbutton.text = "Enter"
        playbutton.fontColor = SKColor.brownColor()
        playbutton.zPosition = 10
        playbutton.name = "playGame"
        
        addChild(playbutton)
        
        let title = SKSpriteNode(imageNamed: "LOGO")
        title.posByCanvas(0.5, y: 1.5)
        title.xScale = 0.3
        title.yScale = 0.2
        title.zPosition = 15
        addChild(title)
        
        title.runAction(SKAction.moveTo(CGPoint(screenX: 0.5, screenY: 0.7), duration: 0.5))
        
        
        #if !os(iOS)
            let exitbutton = SKLabelNode(fontNamed: "DamascusBold")
            exitbutton.posByScreen(0.5, y: 0.3)
            exitbutton.fontSize = 56
            exitbutton.text = "Exit"
            exitbutton.fontColor = SKColor.brownColor()
            exitbutton.zPosition = 10
            exitbutton.name = "exitGame"
            
            addChild(exitbutton)
        #endif
    }
    
    override func screenInteractionStarted(location: CGPoint) {
        for node in nodesAtPoint(location){
            if node.isKindOfClass(SKNode){
                let inGame = node 
                if inGame.name == "playGame" {
                    
                    let playGame = CharSelect(size: scene!.size)
                    playGame.scaleMode = scaleMode
                    let transition = SKTransition.fadeWithDuration(0.6)
                    view?.presentScene(playGame, transition: transition)
            
                }
                
                #if !os(iOS)
                if inGame.name == "exitGame" {
                    NSApplication.sharedApplication().terminate(self)
                }
                #endif
            }
        }
    }
    
}