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


class LevelSelect: SGScene {
    

  var ninjaIndex:Int = 0
  var levelStartIndex = 0
  
  override func didMoveToView(view: SKView) {
    
    
    let background = SKSpriteNode(imageNamed: "BG")
    background.posByCanvas(0.5, y: 0.5)
    background.xScale = 1.2
    background.yScale = 1.2
    background.zPosition = -1
    addChild(background)
    
     let nameBlock = SKLabelNode(fontNamed: "DamascusBold")
    nameBlock.posByScreen(0.5, y: 0.85)
    nameBlock.fontColor = SKColor.whiteColor()
    nameBlock.fontSize = 25
    nameBlock.text = "Select a Level:"
    addChild(nameBlock)

    
//
//    let fontpath:NSString = NSBundle.mainBundle().pathForResource("gamefont", ofType: "skf")!
//    let url:NSURL = NSURL(fileURLWithPath: fontpath as String)!
////    let bitmapFont:SSBitmapFont = SSBitmapFont(file: url, error: nil)
//    
////    let nameBlock:SSBitmapFontLabelNode = bitmapFont.nodeFromString("SELECT A LEVEL")
//    nameBlock.position = CGPoint(screenX: 0.5, screenY: 0.9)
//    nameBlock.zPosition = 10
//    addChild(nameBlock)
    
    let gridSize = CGSize(width: 5, height: 4)
    let gridSpacing = CGSize(width: 160, height: -120)
    let gridStart = CGPoint(screenX: 0.1, screenY: 0.75)
    
    if let levels = gameSettings?.objectForKey("GameParams")?.objectForKey("Levels") as? Array<String> {
      var currentX = 0
      var currentY = 0
      
      var lastAvail = false
      
      for (index, level) in levels.enumerate() {
        
        var available:Bool
        if !(index == 0) {
          available = NSUserDefaults.standardUserDefaults().boolForKey(level)
        } else {
          available = true
        }
        
        let sign = SKSpriteNode(texture: SKTexture(imageNamed: "Sign_1"))
        sign.position = CGPoint(x: gridStart.x + (gridSpacing.width * CGFloat(currentX)), y: gridStart.y + (gridSpacing.height * CGFloat(currentY)))
        sign.size = CGSize(width: 75.6, height: 78)
        sign.zPosition = 20
        sign.userData = ["Index":index, "Level":level, "Available":(available || lastAvail)]
        sign.name = "LevelSign"
        addChild(sign)
        
        let signText = SKLabelNode(fontNamed: "DamascusBold")
        signText.position = sign.position
        signText.fontColor = SKColor.whiteColor()
        signText.fontSize = 32
        signText.zPosition = 21
        signText.text = (available || lastAvail) ? "\(index + 1)" : "X"
        addChild(signText)
        
        let gems = NSUserDefaults.standardUserDefaults().integerForKey("\(level)gems") as Int
        
        for var i = 0; i < gems; i++ {
          let gem = SKSpriteNode(imageNamed: "gem")
          gem.size = CGSize(width: 22, height: 22)
          gem.position = CGPoint(x: (-(sign.size.width / 3) + ((sign.size.width / 3) * CGFloat(i))) as CGFloat , y: -(sign.size.height / 2.5))
          gem.zPosition = 22
          sign.addChild(gem)
        }
        
        currentX++
        if currentX > Int(gridSize.width) {
          currentX = 0
          currentY++
        }
        if available {
          lastAvail = true
        } else {
          lastAvail = false
        }
        
        
      }
      
      
    }
    
    
    }
  
  override func screenInteractionStarted(location: CGPoint) {
    
    for node in nodesAtPoint(location) {
      if node.isKindOfClass(SKNode) {
        let theNode:SKNode = node 
        if  let nodeName = theNode.name {
          if nodeName == "LevelSign" {
            if theNode.userData!["Available"] as! Bool == true {
              let playGame = GameScene(size: scene!.size)
                
              playGame.ninjaIndex = self.ninjaIndex
                
              playGame.currentlevel = theNode.userData!["Level"] as? String
              playGame.scaleMode = self.scaleMode
              let transition = SKTransition.fadeWithDuration(0.6)
              view?.presentScene(playGame, transition: transition)
                
            
            }
          }
        }
      }
    }
  }

}
