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


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  @IBOutlet weak var window: NSWindow!
  @IBOutlet weak var skView: SKView!
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    
    AssetManager.loadSettings()
    
    var resWidth = 1024
    var resHeight = 768
    
    if let resolution = gameSettings?.objectForKey("Defaults")?.objectForKey("OSX-SelectedResolution") as? Int {
      resWidth = ((gameSettings?.objectForKey("Defaults")?.objectForKey("OSX-Resolutions") as! Array<NSDictionary>)[resolution])["Size-Width"] as! Int
      resHeight = ((gameSettings?.objectForKey("Defaults")?.objectForKey("OSX-Resolutions") as! Array<NSDictionary>)[resolution])["Size-Height"] as! Int
    }
    
    let scene = Introducer(size: CGSize(width: resWidth, height: resHeight))
    scene.scaleMode = .AspectFit
    
    let SizeCon:SGResolution = SGResolution(screenSize: skView.bounds.size, canvasSize: scene.size)
    
    self.skView!.presentScene(scene)
    
    self.skView!.ignoresSiblingOrder = true
    
    #if DEBUG
      self.skView!.showsFPS = gameSettings?.objectForKey("Debugging")?.objectForKey("ALL-ShowFrameRate") as! Bool
      self.skView!.showsNodeCount = gameSettings?.objectForKey("Debugging")?.objectForKey("ALL-ShowNodeCount") as! Bool
    #endif
    
    if (gameSettings?.objectForKey("Defaults")?.objectForKey("OSX-Start-FullScreen") as! Bool) {
      window.toggleFullScreen(nil)
    }
    
  }
  
  func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
    return true
  }
}
