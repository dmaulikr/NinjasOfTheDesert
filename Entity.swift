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

struct ColliderType {
  static let Player:      UInt32 = 0
  static let Destroyable: UInt32 = 0b1
  static let Wall:        UInt32 = 0b10
  static let Collectible: UInt32 = 0b100
  static let Trigger:     UInt32 = 0b1000
  static let Projectile:  UInt32 = 0b10000
  static let Enemy:       UInt32 = 0b100000
  static let None:        UInt32 = 0b1000000
}

class Entity: SKSpriteNode {
  
  var entityID:Int?
  var entityDescription:String = "Entity"
  
  //MARK: Initializers
  
  override init(texture: SKTexture?, color: SKColor, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(entityPosition:CGPoint, entitySize:CGSize, entID:Int) {
    
    self.init(texture: nil, color: nil, size: entitySize)
    self.entityID = entID
    self.position = entityPosition
    self.buildSprite()
    self.configureCollisionBody()
  }
  
  //MARK: Loop
  
  func update(delta:CFTimeInterval) {
    
    // Overridden by subclasses
    
  }
  
  //MARK: Collisions
  
  func configureCollisionBody() {
    
    // Overridden by subclasses
    
  }
  
  func collidedWith(body:SKPhysicsBody, contact:SKPhysicsContact) {
    
    // Overridden by subclasses
    
  }
  
  //MARK: Entity Functions
  
  func buildSprite() {
    
    // Overridden by subclasses
    
  }
  
  func destroy() {
    removeAllActions()
    runAction(SKAction.sequence([SKAction.fadeAlphaTo(0.0, duration: 0.2),SKAction.removeFromParent()]))
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
