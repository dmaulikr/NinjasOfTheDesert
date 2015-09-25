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

var health = 1.0


class Destructible : Entity {
  
  override func configureCollisionBody() {
    
    physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width * 0.98, height: self.size.height * 0.98))
    physicsBody?.affectedByGravity = true
    physicsBody?.dynamic = true
    physicsBody?.categoryBitMask = ColliderType.Destroyable
    physicsBody?.collisionBitMask = ColliderType.Wall | ColliderType.Player | ColliderType.Destroyable
  }
  
  override func collidedWith(body:SKPhysicsBody, contact:SKPhysicsContact) {
    
  }
  
  override func buildSprite() {
    
    entityDescription = "crate"
    
    let atlas = SKTextureAtlas(named: "Tiles")
    texture = atlas.textureNamed("Crate")
    zPosition = 50
    
  }
  
  override func destroy() {
    damageInflicted(0.6)
  }
  
  func damageInflicted(dmg:Double) {
    health = health - dmg
    
//    let emitter = SKEmitterNode(fileNamed: "ImpactMark")
////    emitter.position = self.position
//    emitter.zPosition = 80
//    self.parent?.addChild(emitter)
//    emitter.runAction(SKAction.sequence([SKAction.waitForDuration(0.35),SKAction.removeFromParent()]))
//    
    if health < 0.0 {
      removeAllActions()
      runAction(SKAction.sequence([SKAction.fadeAlphaTo(0.0, duration: 0.2),SKAction.removeFromParent()]))
    }
  }
  
}