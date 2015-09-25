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

class Trigger : Entity {
  
  override func update(delta:CFTimeInterval) {
    
    
  }
  
  override func configureCollisionBody() {
    
    physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width * 0.7, height: self.size.height * 0.7))
    physicsBody?.affectedByGravity = false
    physicsBody?.categoryBitMask = ColliderType.Trigger
    physicsBody?.collisionBitMask = ColliderType.None
    physicsBody?.contactTestBitMask = ColliderType.Player
    
  }
  
  override func collidedWith(body:SKPhysicsBody, contact:SKPhysicsContact) {
    
    if let mainscene = self.parent?.parent?.parent as? GameScene {
      mainscene.triggerWithCommand(entityDescription)
    }
    destroy()
    
  }
  
  override func buildSprite() {
    
    entityDescription = "finish-level"
    
  }
  
  func gemTexture() {
    
    let atlas = SKTextureAtlas(named: "Tiles")
    texture = atlas.textureNamed("gem")
  }
  
  
}
