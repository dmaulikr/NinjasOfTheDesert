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

extension SKNode {
  
  func posByScreen(x: CGFloat, y: CGFloat) {
    self.position = CGPoint(x: CGFloat((SKMUIRect!.width * x) + SKMUIRect!.origin.x), y: CGFloat((SKMUIRect!.height * y) + SKMUIRect!.origin.y))
  }
  
  func posByCanvas(x: CGFloat, y: CGFloat) {
    self.position = CGPoint(x: CGFloat(SKMSceneSize!.width * x), y: CGFloat(SKMSceneSize!.height * y))
  }
  
  class func unarchiveFromFile(file : NSString) -> SKNode? {
    if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
      let sceneData = try? NSData(contentsOfFile:path, options: .DataReadingMappedIfSafe)
      let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData!)
      
      archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
      let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKScene
      archiver.finishDecoding()
      return scene
    } else {
      return nil
    }
  }
  
}

extension CGSize {
  
  public init(screenWidth: CGFloat, screenHeight: CGFloat) {
    if (SKMSceneSize != nil && SKMViewSize != nil) {
      self.init(width: screenWidth * (SKMViewSize!.height / SKMSceneSize!.height), height: screenHeight * (SKMViewSize!.height / SKMSceneSize!.height))
    } else {
      self.init(width: screenWidth, height: screenHeight)
    }
  }
  
  public init(canvasWidth: CGFloat, canvasHeight: CGFloat) {
    self.init(width: canvasWidth, height: canvasHeight)
  }
  
}

extension CGPoint {
  
  public init(screenX: CGFloat, screenY: CGFloat) {
    self.init(x: CGFloat((SKMUIRect!.width * screenX) + SKMUIRect!.origin.x), y: CGFloat((SKMUIRect!.height * screenY) + SKMUIRect!.origin.y))
  }
  
  public init(canvasX: CGFloat, canvasY: CGFloat) {
    self.init(x: CGFloat(SKMSceneSize!.width * canvasX), y: CGFloat(SKMSceneSize!.height * canvasY))
  }
  
  public init(radius:CGFloat, degrees:CGFloat) {
    self.init(x: radius * cos(degrees),y: radius * sin(degrees))
  }
  
  public init(point:CGPoint, radius:CGFloat, degrees:CGFloat) {
    let newPoint = point + CGPoint(radius: radius, degrees: degrees)
    self.init(x:newPoint.x,y:newPoint.y)
  }
  
}

extension CGFloat {
  
  func string(fractionDigits:Int) -> String {
    let formatter = NSNumberFormatter()
    formatter.minimumFractionDigits = fractionDigits
    formatter.maximumFractionDigits = fractionDigits
    return formatter.stringFromNumber(self)!
  }
  
}

extension String {
  
  public init(stringForGD:String) {
  
    #if os(iOS)
      /*var myString = ""
      for char in stringForGD {
        myString = "\(myString)\(char)  "
      }
      self.init(myString)*/
      self.init(stringForGD)
    #else
      self.init(stringForGD)
    #endif
  }
  
}
