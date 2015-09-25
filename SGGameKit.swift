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

import GameKit
import Foundation

let PresentAuthenticationViewController = "PresentAuthenticationViewController"
let singleton = SGGameKit()

class SGGameKit: NSObject {
  #if os(iOS)
  var authenticationViewController: UIViewController?
  #else
  var authenticationViewController: NSViewController?
  #endif
  var lastError: NSError?
  var gameCenterEnabled: Bool
  
  class var sharedInstance: SGGameKit {
    return singleton
  }
  
  override init() {
    gameCenterEnabled = true
    super.init()
  }
  
  func authenticateLocalPlayer() {
    
    let localPlayer = GKLocalPlayer.localPlayer()
    
    #if os(iOS)
    localPlayer.authenticateHandler = {(viewController, error) in
      self.lastError = error
      if viewController != nil {
        self.authenticationViewController = viewController
        NSNotificationCenter.defaultCenter().postNotificationName(PresentAuthenticationViewController,
          object: self)
      } else if localPlayer.authenticated {
        self.gameCenterEnabled = true
      } else {
        self.gameCenterEnabled = false
      }
    }
    #else
    localPlayer.authenticateHandler = {(viewController, error) in
      self.lastError = error
        if viewController != nil {
          let presenter = GKDialogController.sharedDialogController()
          presenter.parentWindow = NSApplication.sharedApplication().windows[0] as! NSWindow
          presenter.presentViewController(viewController as NSViewController)
        } else if localPlayer.authenticated {
          self.gameCenterEnabled = true
        } else {
          self.gameCenterEnabled = false
        }
      }
    #endif
  }
  
  //TODO: Fix Errors
  
  #if os(iOS)
  func showGKGameCenterViewController(viewController: UIViewController!, state: Int) {
    
    if !gameCenterEnabled {
      print("Local player is not authenticated")
      return
    }
    
    let gameCenterViewController = GKGameCenterViewController()
    gameCenterViewController.gameCenterDelegate = self
    
    switch state {
    case 1:
      gameCenterViewController.viewState = .Achievements
      break
    case 2:
      gameCenterViewController.viewState = .Leaderboards
      break
    default:
      break
    }
    viewController.presentViewController(gameCenterViewController,
      animated: true, completion: nil)
  }
  
  func reportAchievements(achievements: [GKAchievement]) {
    if !gameCenterEnabled {
      print("Local player is not authenticated")
      return
    }
    GKAchievement.reportAchievements(achievements) {(error) in
      self.lastError = error
    }
  }
  
  func reportScore(score: Int64, forLeaderBoardId leaderBoardId: String) {
    
    if !gameCenterEnabled {
      print("Local player is not authenticated")
      return
    }
    
    let scoreReporter = GKScore(leaderboardIdentifier: leaderBoardId)
    scoreReporter.value = score
    scoreReporter.context = 0
    
    let scores = [scoreReporter]
    
    GKScore.reportScores(scores) {(error) in
      self.lastError = error
    }
  }
  #endif
  
}

extension SGGameKit: GKGameCenterControllerDelegate {
  
  func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
    #if os(iOS)
    gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    #endif
  }
  
}

