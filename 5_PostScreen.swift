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

class PostScreen: SGScene {
  
  var level:String?
  var win:Bool?
  var gems:Int?
  
  override func didMoveToView(view: SKView) {
    
    layoutScene()
    saveStats()
    
  }
  
  func layoutScene() {
    
    let background = SKSpriteNode(imageNamed: "BG")
    background.posByCanvas(0.5, y: 0.5)
    background.xScale = 1.2
    background.yScale = 1.2
    background.zPosition = -1
    addChild(background)
    
    let nameBlock = SKLabelNode(fontNamed: "DamascusBold")
    nameBlock.posByScreen(0.5, y: 0.5)
    nameBlock.fontColor = SKColor.whiteColor()
    nameBlock.fontSize = 64
    if (win != nil) {
      nameBlock.text = win! ? "You Passed!" : "You Failed!"
    }
    addChild(nameBlock)
    
//    let fontpath:NSString = NSBundle.mainBundle().pathForResource("gamefont", ofType: "skf")!
////    let url:NSURL = NSURL(fileURLWithPath: fontpath as String)!
////    let bitmapFont:SSBitmapFont = SSBitmapFont(file: url, error: nil)
//    
//    
//    let nameBlock:SSBitmapFontLabelNode = bitmapFont.nodeFromString(win! ? "YOU PASSED" : "YOU FAILED")
//    nameBlock.position = CGPoint(screenX: 0.5, screenY: 0.5)
//    nameBlock.zPosition = 10
//    addChild(nameBlock)
//    
  }
  
  func saveStats() {
    if win! {
      NSUserDefaults.standardUserDefaults().setBool(true, forKey: level!)
      if gems! > NSUserDefaults.standardUserDefaults().integerForKey("\(level!)gems") {
        NSUserDefaults.standardUserDefaults().setInteger(gems!, forKey: "\(level!)gems")
      }
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
  
  override func screenInteractionStarted(location: CGPoint) {
    
    let mainMenu = MainMenu(size: self.scene!.size)
    mainMenu.scaleMode = self.scaleMode
    self.view?.presentScene(mainMenu, transition: SKTransition.fadeWithDuration(0.6))
    
  }
  
}
