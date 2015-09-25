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

class LayerBackground: Layer {
  
  override func updateNodes(delta:CFTimeInterval,childNumber:Int,childNode:SKNode) {
    if let node = childNode as? SKSpriteNode {
      if node.position.x <= (-(node.size.width - 2)) {
        if node.name == "A" && childNodeWithName("B") != nil {
          node.position = CGPoint(x: childNodeWithName("B")!.position.x + node.size.width - 2, y: node.position.y)
        } else if node.name == "B" && childNodeWithName("A") != nil {
          node.position = CGPoint(x: childNodeWithName("A")!.position.x + node.size.width - 2, y: node.position.y)
        }
      }
    }
  }
  
}
