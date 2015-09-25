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

class LayerWorld: Layer {
  
  let tileSize: CGSize
  var atlas: SKTextureAtlas?
  let gridSize: CGSize
  let layerSize: CGSize
  
  override func updateNodes(delta:CFTimeInterval,childNumber:Int,childNode:SKNode) {
    if let node = childNode as? SKSpriteNode {
      if node.position.x <= (-(node.size.width + 2)) {
        node.removeFromParent()
      }
    }
  }
  
  init(tileSize: CGSize, gridSize: CGSize,
    layerSize: CGSize? = nil) {
      self.tileSize = tileSize
      self.gridSize = gridSize
      if layerSize != nil {
        self.layerSize = layerSize!
      } else {
        self.layerSize = CGSize(width: tileSize.width * gridSize.width,height: tileSize.height * gridSize.height)
      }
      super.init()
  }
  
  convenience init(atlasName: String, tileSize: CGSize,
    tileCodes: [String]) {
      self.init(tileSize: tileSize,
        gridSize: CGSize(width: tileCodes[0].characters.count,
          height: tileCodes.count))
      
      atlas = SKTextureAtlas(named: atlasName)
      
      for row in 0..<tileCodes.count {
        let line = tileCodes[row]
        for (col, code) in line.characters.enumerate() {
          if let tile = nodeForCode(code) {
            tile.position = positionForRow(row, col: col)
            if tile.name == "scenery" {
              tile.position = CGPoint(x: tile.position.x, y: tile.position.y - (tileSize.height/2))
            }
            addChild(tile)
          }
        }
      }
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func nodeForCode(tileCode: Character) -> SKNode? {
    
    if atlas == nil {
      return nil
    }
    
    var tile: SKNode?
    switch tileCode {
    case "1":
      tile = SKSpriteNode(texture: atlas!.textureNamed("1"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = true
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "2":
      tile = SKSpriteNode(texture: atlas!.textureNamed("2"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = true
      tile?.physicsBody = SKPhysicsBody(edgeFromPoint: CGPoint(x: -(tileSize.width/2), y: tileSize.height/2), toPoint: CGPoint(x: tileSize.width, y: tileSize.height/2))
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "3":
      tile = SKSpriteNode(texture: atlas!.textureNamed("3"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "4":
      tile = SKSpriteNode(texture: atlas!.textureNamed("4"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "5":
      tile = SKSpriteNode(texture: atlas!.textureNamed("5"))
      tile?.zPosition = 50
    case "6":
      tile = SKSpriteNode(texture: atlas!.textureNamed("6"))
      tile?.zPosition = 50
    case "7":
      tile = SKSpriteNode(texture: atlas!.textureNamed("7"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "8":
      tile = SKSpriteNode(texture: atlas!.textureNamed("8"))
      tile?.zPosition = 50
    case "9":
      tile = SKSpriteNode(texture: atlas!.textureNamed("9"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "A":
      tile = SKSpriteNode(texture: atlas!.textureNamed("10"))
      tile?.zPosition = 50
    case "B":
      tile = SKSpriteNode(texture: atlas!.textureNamed("11"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "C":
      tile = SKSpriteNode(texture: atlas!.textureNamed("12"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "D":
      tile = SKSpriteNode(texture: atlas!.textureNamed("14"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "E":
      tile = SKSpriteNode(texture: atlas!.textureNamed("15"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(origin: CGPoint(x: -(tileSize.width/2), y: -(tileSize.height/2)), size: tileSize))
      
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "F":
      tile = SKSpriteNode(texture: atlas!.textureNamed("16"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "G":
      tile = SKSpriteNode(texture: atlas!.textureNamed("14"))
      tile?.zPosition = 50
      tile?.physicsBody?.dynamic = false
      tile?.physicsBody = SKPhysicsBody(rectangleOfSize: tileSize)
      tile?.physicsBody?.categoryBitMask = ColliderType.Wall
      tile?.physicsBody?.collisionBitMask = ColliderType.Enemy | ColliderType.Player | ColliderType.Destroyable | ColliderType.Collectible
      tile?.physicsBody?.affectedByGravity = false
    case "H":
      tile = SKSpriteNode(texture: atlas!.textureNamed("17"))
      tile?.zPosition = 50
    case "I":
      tile = SKSpriteNode(texture: atlas!.textureNamed("18"))
      tile?.zPosition = 50
    case "K":
      let options = ["Sign","SignArrow","Skeleton","Stone","Tree_1","Tree"]
      tile = SKSpriteNode(texture: atlas!.textureNamed(options[Int.random(0..<options.count)]))
      tile?.zPosition = CGFloat.random() < 0.67 ? 40 : 60
      tile?.name = "scenery"
    case "L":
      tile = SKNode()
      let crate = Destructible(entityPosition: CGPointZero, entitySize:tileSize, entID: 0)
      tile?.addChild(crate)
    case "M":
      tile = SKSpriteNode(texture: atlas!.textureNamed("Sign_2"))
      tile?.zPosition = 50
      tile?.name = "scenery"
     case "N":
      tile = SKNode()
      let trigger = Trigger(entityPosition: CGPointZero, entitySize:tileSize, entID: 0)
      trigger.entityDescription = "add-gem"
      trigger.size = CGSize(width: 64, height: 64)
      trigger.gemTexture()
      trigger.zPosition = 65
      tile?.addChild(trigger)
    case "X":
      tile = SKNode()
     let trigger = Trigger(entityPosition: CGPointZero, entitySize:tileSize, entID: 0)
      trigger.entityDescription = "finish-level"
      tile?.addChild(trigger)
    default:
      print("Unknown tile code \(tileCode)")
    
    }
    
    if let sprite = tile as? SKSpriteNode {
      if sprite.name == "scenery" {
        sprite.anchorPoint = CGPoint(x: 0.5, y: 0.0)
      } else {
        sprite.size = tileSize
      }
    }
    return tile
  }
  
  func positionForRow(row: Int, col: Int) -> CGPoint {
    let x = CGFloat(col) * tileSize.width + tileSize.width / 2
    let y = CGFloat(row) * tileSize.height + tileSize.height / 2
    return CGPoint(x: x, y: layerSize.height - y)
  }
  
}