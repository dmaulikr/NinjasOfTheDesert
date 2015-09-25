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

import UIKit
import SpriteKit
import iAd

class GameViewController: UIViewController, ADBannerViewDelegate {

    var bannerView: ADBannerView = ADBannerView()
    
    func appDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        
        #if FREE
            
            let sh = UIScreen.mainScreen().bounds.width
           bannerView.delegate = self
            bannerView = self.appDelegate().iad
            bannerView.frame = CGRectMake(0, 0, sh, 0)
            self.view.addSubview(bannerView)
        #endif
    }
    
    override func viewWillDisappear(animated: Bool) {
        #if FREE
         bannerView.delegate = self
            bannerView.removeFromSuperview()
            
        #endif
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()

 

    
    AssetManager.loadSettings()
    
    //Authenticate Game Center
    
//    NSNotificationCenter.defaultCenter().addObserver(self, selector:
//      Selector("showAuthenticationViewController"), name:
//      PresentAuthenticationViewController, object: nil)
//    
//    SGGameKit.sharedInstance.authenticateLocalPlayer()
    
    //Load View and Scene
    
    let scene = Introducer(size: CGSize(width: 1024, height: 768))
    let skView = self.view as! SKView
    
    skView.multipleTouchEnabled = true
    
    #if DEBUG
      skView.showsFPS = gameSettings?.objectForKey("Debugging")?.objectForKey("ALL-ShowFrameRate") as! Bool
      skView.showsNodeCount = gameSettings?.objectForKey("Debugging")?.objectForKey("ALL-ShowNodeCount") as! Bool
      skView.showsDrawCount = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowDrawCount") as! Bool
      skView.showsQuadCount = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowQuadCount") as! Bool
      skView.showsPhysics = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowPhysics") as! Bool
      skView.showsFields = gameSettings?.objectForKey("Debugging")?.objectForKey("IOS-ShowFields") as! Bool
    #endif
    
    skView.ignoresSiblingOrder = true
    
    scene.scaleMode = .AspectFill
    
    let SizeCon:SGResolution = SGResolution(screenSize: view.bounds.size, canvasSize: scene.size)
    
    skView.presentScene(scene)
}

  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.Landscape
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
//  //MARK: Game Center
//  
//  func showAuthenticationViewController() {
//    let gameKitHelper = SGGameKit.sharedInstance
//    
//    if let authenticationViewController = gameKitHelper.authenticationViewController {
//      self.presentViewController(authenticationViewController, animated: true,
//        completion: nil)
//    }
//  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        bannerView.alpha = 1
        UIView.commitAnimations()
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        bannerView.alpha = 0
        UIView.commitAnimations()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }

}
