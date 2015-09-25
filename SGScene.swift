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

class SGScene: SKScene {
  
  var isScenePaused = false
  
  #if os(iOS)
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    for touch: AnyObject in touches {
      let location = touch.locationInNode(self)
      screenInteractionStarted(location)
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    for touch: AnyObject in touches {
      let location = touch.locationInNode(self)
      screenInteractionMoved(location)
    }
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    for touch: AnyObject in touches {
      let location = touch.locationInNode(self)
      screenInteractionEnded(location)
    }
  }
  
  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    
    for touch: AnyObject in touches {
      let location = touch.locationInNode(self)
      screenInteractionEnded(location)
    }
  }
  
  #else
  
  override func mouseDown(theEvent: NSEvent) {
  
  let location = theEvent.locationInNode(self)
  screenInteractionStarted(location)
  
  }
  
  override func mouseDragged(theEvent: NSEvent) {
  
  let location = theEvent.locationInNode(self)
  screenInteractionMoved(location)
  }
  
  override func mouseUp(theEvent: NSEvent) {
  
  let location = theEvent.locationInNode(self)
  screenInteractionEnded(location)
  
  }
  
  override func mouseExited(theEvent: NSEvent) {
  
  let location = theEvent.locationInNode(self)
  screenInteractionEnded(location)
  
  }
  
  #endif
  
  #if !os(iOS)
  
  override func keyDown(theEvent: NSEvent) {
  handleKeyEvent(theEvent, keyDown: true)
  }
  
  override func keyUp(theEvent: NSEvent) {
  handleKeyEvent(theEvent, keyDown: false)
  }
  
  func handleKeyEvent(event: NSEvent, keyDown: Bool) {
  /* Overridden by Subclass */
  }
  
  #endif
  
  //PUBLIC METHODS TO BE OVERRIDDEN
  
  func screenInteractionStarted(location: CGPoint) {
    /* Overridden by Subclass */
  }
  
  func screenInteractionMoved(location: CGPoint) {
    /* Overridden by Subclass */
  }
  
  func screenInteractionEnded(location: CGPoint) {
    /* Overridden by Subclass */
  }
  
  func pauseGame(toggle:Bool) {
    /* Overridden by Subclass */
  }
  
  func buttonEvent(event:String,velocity:Float,pushedOn:Bool) {
    /* Overridden by Subclass */
  }
  
}