//
//  layerHUD.swift
//  SG_Template
//
//  Created by Kailash Ramaswamy on 29/06/15.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class layerHUD: SKNode {
    
    var throwcount:SKLabelNode!
    
    var jumpbutton: SKLabelNode!
    var pausebutton: SKLabelNode!
    var throwbutton: SKLabelNode!
    
    override init() {
        super.init()
        
        pausebutton = SKLabelNode(fontNamed: "DamascusBold")
        pausebutton.fontSize = 42
        pausebutton.posByScreen(0.95, y: 0.95)
        pausebutton.fontColor = SKColor.whiteColor()
        pausebutton.alpha = 0.8
        pausebutton.horizontalAlignmentMode = .Right
        pausebutton.verticalAlignmentMode = .Top
        pausebutton.zPosition = 500
        pausebutton.text = "II"
        #if !os(iOS)
            pausebutton.text = "Press P to Pause"
            pausebutton.fontSize = 24
        #endif
        pausebutton.name = "pauseButton"
        addChild(pausebutton)
        
        jumpbutton = SKLabelNode(fontNamed: "DamascusBold")
        jumpbutton.fontSize = 54
        jumpbutton.posByScreen(0.95, y: 0.05)
        jumpbutton.fontColor = SKColor.whiteColor()
        jumpbutton.alpha = 0.8
        jumpbutton.horizontalAlignmentMode = .Right
        jumpbutton.verticalAlignmentMode = .Bottom
        jumpbutton.zPosition = 500
        jumpbutton.text = "Jump"
        #if !os(iOS)
            jumpbutton.text = "Press X to Jump"
            jumpbutton.fontSize = 24
        #endif
        jumpbutton.name = "jumpButton"
        addChild(jumpbutton)
        
        
        throwbutton = SKLabelNode(fontNamed: "DamascusBold")
        throwbutton.fontSize = 54
        throwbutton.posByScreen(0.05, y: 0.05)
        throwbutton.fontColor = SKColor.whiteColor()
        throwbutton.alpha = 0.8
        throwbutton.horizontalAlignmentMode = .Left
        throwbutton.verticalAlignmentMode = .Bottom
        throwbutton.zPosition = 500
        throwbutton.text = "Throw"
        #if !os(iOS)
            throwbutton.text = "Press Z to Throw"
            throwbutton.fontSize = 24
        #endif
        throwbutton.name = "throwButton"
        addChild(throwbutton)
        
        
        throwcount = SKLabelNode(fontNamed: "DamascusBold")
        throwcount.fontSize = 32
        throwcount.posByScreen(0.5, y: 0.02)
        throwcount.fontColor = SKColor.whiteColor()
        throwcount.alpha = 0.8
        throwcount.horizontalAlignmentMode = .Center
        throwcount.verticalAlignmentMode = .Bottom
        throwcount.zPosition = 500
        throwcount.text = "Bullets: 3"
        throwcount.name = "throwButton"
        addChild(throwcount)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(delta: CFTimeInterval){
        throwcount.text = "Bullets: \((3 - (self.parent as! GameScene).layerprojectile.children.count)) "
    }
}
