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

/*
The job of the introducer is to continue from the launch screen and do any further pre-loading for pre-game assets.
It also segues elegently to the scene as opposed to BAM! scene.
*/


import SpriteKit

class Introducer: SKScene {
  
  var logoSprite:SKSpriteNode?
  var isLoading = false
  
  override func didMoveToView(view: SKView) {
    
    //Set a background color
    self.backgroundColor = SKColor.blackColor()
    
//    //Animate initial
    let atlas = SKTextureAtlas(named: "SampleAssets")
    logoSprite = SKSpriteNode(texture: atlas.textureNamed("SwiftGamer"))
    logoSprite!.posByCanvas(0.5, y: 0.5)
    addChild(logoSprite!)
    
    let animInitial:SKAction = SKAction.group([SKAction.scaleTo(1.0, duration: 0.8),SKAction.fadeAlphaTo(1.0, duration: 0.6)])
    
    //Animate Fill
    let animFill:SKAction = SKAction.repeatActionForever(SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.6),SKAction.scaleTo(1.0, duration: 0.6),
      SKAction.runBlock({ () -> Void in
        if (self.isLoading != true) {self.startLoadingAssets()}
    })]))
    
    //Animate
    
    if (logoSprite != nil) {
      if (gameSettings?.objectForKey("Defaults")?.objectForKey("ALL-Introduce") as! Bool) {
        logoSprite!.alpha = 0.0
        logoSprite!.xScale = 0.0
        logoSprite!.yScale = 0.0
        logoSprite!.runAction(SKAction.sequence([animInitial,animFill]))
        
      } else {
        logoSprite!.alpha = 1.0
        logoSprite!.xScale = 1.0
        logoSprite!.yScale = 1.0
        startLoadingAssets()
      }
    }
    
  }
  
  func startLoadingAssets() {
    
    let startTime = CACurrentMediaTime()
    isLoading = true
    
    //Prepare textures to load
    var textureAtlasesArray : [SKTextureAtlas] = []
    let atlas01 = SKTextureAtlas(named: "Tiles")
    textureAtlasesArray.append(atlas01)
    let atlas02 = SKTextureAtlas(named: "Male")
    textureAtlasesArray.append(atlas02)
    let atlas03 = SKTextureAtlas(named: "Tiles")
    textureAtlasesArray.append(atlas03)

    
    //Prepare sounds to load
    SKTAudio.sharedInstance().playBackgroundMusic("music.wav")
    SKTAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.6
    
    SKTextureAtlas.preloadTextureAtlases(textureAtlasesArray, withCompletionHandler: {
      gameTextures = textureAtlasesArray
      let endTime = CACurrentMediaTime()
      let timeDifference = endTime - startTime
      print(NSString(format: "Loaded Texture Atlases in %0.2f seconds", timeDifference))
      self.transitionToNextScene()
    })
    
  }
  
  func transitionToNextScene() {
    let mainMenu = MainMenu(size: self.scene!.size)
    mainMenu.scaleMode = self.scaleMode
    self.view?.presentScene(mainMenu, transition: SKTransition.fadeWithDuration(0.6))
  }
  
}
