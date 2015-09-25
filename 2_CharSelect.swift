/*
* Copyright (c) 2014 Neil North.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import SpriteKit

class CharSelect: SGScene {
  
  override func didMoveToView(view: SKView) {
    let background = SKSpriteNode(imageNamed: "BG")
    background.posByCanvas(0.5, y: 0.5)
    background.xScale = 1.2
    background.yScale = 1.2
    background.zPosition = -1
    addChild(background)
    
    let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    nameBlock.posByScreen(0.5, y: 0.8)
    nameBlock.fontColor = SKColor.whiteColor()
    nameBlock.fontSize = 54
    nameBlock.text = "Select a Character:"
    addChild(nameBlock)
//    
//    let fontpath:NSString = NSBundle.mainBundle().pathForResource("gamefont", ofType: "skf")!
//    let url:NSURL = NSURL(fileURLWithPath: fontpath as String)!
//    let bitmapFont:SSBitmapFont = SSBitmapFont(file: url, error: nil)
    
//    let nameBlock:SSBitmapFontLabelNode = bitmapFont.nodeFromString("SELECT A CHARACTER")
//    nameBlock.position = CGPoint(screenX: 0.5, screenY: 0.9)
//    nameBlock.zPosition = 10
//    addChild(nameBlock)
    
    if let chars = gameSettings?.objectForKey("GameParams")?.objectForKey("Players") as? Array<NSDictionary> {
      let count = chars.count
      
      for (index, char) in chars.enumerate() {
        let textureAtlas = SKTextureAtlas(named: char.objectForKey("Anim_Idle")?.objectForKey("AtlasFileName") as! String)
        let charNode = SKSpriteNode(texture: textureAtlas.textureNamed((char.objectForKey("Anim_Idle")?.objectForKey("Frames") as! Array<String>)[0]))
        let locX:Double = (1.0 / Double(count + 1))
        let location = locX + (locX * Double(index))
        charNode.posByScreen(CGFloat(location), y: 0.5)
        charNode.size = CGSize(width: 232, height: 439)
        charNode.xScale = 0.5
        charNode.yScale = 0.5
        charNode.name = "C\(index)"
        charNode.userData = ["Index":index]
        addChild(charNode)
        
        let anim_idle = prepareAnimationForDictionary(char.objectForKey("Anim_Idle") as! NSDictionary, repeated: true)
        charNode.runAction(anim_idle)
        
        let nameBlock = SKLabelNode(fontNamed: "DamascusBold")
        nameBlock.posByScreen(CGFloat(location), y: 0.25)
        nameBlock.fontColor = SKColor.blackColor()
        nameBlock.fontSize = 32
        nameBlock.text = char["PlayerName"] as! String
        addChild(nameBlock)
        
//        let nameBlock:SSBitmapFontLabelNode = bitmapFont.nodeFromString(char["PlayerName"] as! String)
//        nameBlock.position = CGPoint(screenX: CGFloat(location), screenY: 0.25)
//        nameBlock.zPosition = 10
//        nameBlock.xScale = 0.5
//        nameBlock.yScale = 0.5
//        addChild(nameBlock)
        
      }
    }
  }
  
  override func screenInteractionStarted(location: CGPoint) {
    for node in nodesAtPoint(location) {
      if node.isKindOfClass(SKNode) {
        let theNode:SKNode = node 
        if  let nodeName = theNode.name {
          if nodeName.hasPrefix("C") {
            let playGame = LevelSelect(size: scene!.size)
            playGame.ninjaIndex = theNode.userData!["Index"] as! Int
            playGame.scaleMode = self.scaleMode
            let transition = SKTransition.fadeWithDuration(0.6)
            view?.presentScene(playGame, transition: transition)
          }
        }
      }
    }
  }
  
  
  func prepareAnimationForDictionary(settings:NSDictionary, repeated:Bool) -> SKAction {
    
    let atlas:SKTextureAtlas = SKTextureAtlas(named: settings["AtlasFileName"] as! String)
    let textureNames:NSArray = settings["Frames"] as! NSArray
    var texturePack:NSMutableArray = []
    
    for texPath in textureNames {
      texturePack.addObject(atlas.textureNamed(texPath as! String))
    }
    
    let timePerFrame:NSTimeInterval = Double(1.0/(settings["FPS"] as! Float))
    
    let anim:SKAction = SKAction.animateWithTextures(texturePack as [AnyObject], timePerFrame: timePerFrame)
    
    if repeated {
      return SKAction.repeatActionForever(anim)
    } else {
      return anim
    }
  }
}
