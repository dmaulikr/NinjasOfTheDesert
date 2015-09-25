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

class ThrowWeapon : Entity {
  
  override func configureCollisionBody() {
    
    physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width * 3, height: self.size.height * 3))
    physicsBody?.affectedByGravity = false
    physicsBody?.categoryBitMask = ColliderType.Projectile
    physicsBody?.collisionBitMask = ColliderType.None
    physicsBody?.contactTestBitMask = ColliderType.Destroyable | ColliderType.Enemy
    
  }
  
  override func collidedWith(body:SKPhysicsBody, contact:SKPhysicsContact) {
    
    if let target = body.node as? Entity {
      target.destroy()
      self.removeFromParent()
    }
    
  }
  
  override func buildSprite() {
    
    entityDescription = "weapon"
    
    let atlas = SKTextureAtlas(named: "Male")
    texture = atlas.textureNamed("Bullet_000")
    zPosition = 70
    
    userData = ["startX":position.x]
    
  }
  
  
}