//
//  DebugVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import CoreLocation
import JSQNotificationObserverKit
import TransitionKit

typealias ButtonUpdateInfo = (title: String, action: Selector)

class DebugVC: UIViewController {
  var sfoObservers = SfoObservers()
  var reachabilityObserver: ReachabilityObserver?

  override func loadView() {
    let debugView = DebugView(frame: UIScreen.mainScreen().bounds)
    view = debugView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupAviObservers()
    setupCidObservers()
    setupDriverObservers()
    setupGeofenceObservers()
    setupLocationObservers()
    setupPingObservers()
    setupRequestObservers()
    setupStateObservers()
    setupTripObservers()
    
    reachabilityObserver = NotificationObserver(notification: SfoNotification.Reachability.reachabilityChanged) { reachable, _ in
      self.debugView().setReachabilityNoticeHidden(reachable)
      if reachable {
        self.debugView().printDebugLine("network reachable", type: .Positive)
      } else {
        self.debugView().printDebugLine("network unreachable", type: .Negative)
      }
    }

    configureNavBar(back: true, title: "Debug")
    addSettingsButton()
    
    updateForState(StateManager.sharedInstance.getMachine().currentState)
  }
  
  func debugView() -> DebugView {
    return self.view as! DebugView
  }
  
  func updateFakeButtons(first: ButtonUpdateInfo?, second: ButtonUpdateInfo? = nil, third: ButtonUpdateInfo? = nil) {
    updateButton(self.debugView().fakeButton, info: first)
    updateButton(self.debugView().secondFakeButton, info: second)
    updateButton(self.debugView().thirdFakeButton, info: third)
  }
  
  private func updateButton(button: UIButton, info: ButtonUpdateInfo?) {
    if let info = info {
      button.setTitle(info.title, forState: .Normal)
      button.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
      button.addTarget(self, action: info.action, forControlEvents: .TouchUpInside)
    } else {
      button.setTitle("Not Active", forState: .Normal)
      button.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
    }
  }
}
