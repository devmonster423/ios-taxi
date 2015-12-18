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

  override func loadView() {
    let debugView = DebugView(frame: UIScreen.mainScreen().bounds)
    debugView.logOutButton.addTarget(self,
      action: "logout",
      forControlEvents: .TouchUpInside)
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
