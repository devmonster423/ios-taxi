//
//  DebugVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import CoreLocation
import TransitionKit

typealias ButtonUpdateInfo = (title: String, action: Selector)

class DebugVC: UIViewController {
  
  override func loadView() {
    let debugView = DebugView(frame: UIScreen.main.bounds)
    debugView.setReachabilityNoticeHidden(ReachabilityManager.sharedInstance.isReachable())
    view = debugView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupObservers()
    
    configureNavBar(back: true, title: "Debug")
    addSettingsButton()
    
    updateForState(StateManager.sharedInstance.getMachine().currentState)
  }
  
  func debugView() -> DebugView {
    return self.view as! DebugView
  }
  
  func updateFakeButtons(_ first: ButtonUpdateInfo?, second: ButtonUpdateInfo? = nil, third: ButtonUpdateInfo? = nil) {
    updateButton(self.debugView().fakeButton, info: first)
    updateButton(self.debugView().secondFakeButton, info: second)
    updateButton(self.debugView().thirdFakeButton, info: third)
  }
  
  private func updateButton(_ button: UIButton, info: ButtonUpdateInfo?) {
    if let info = info {
      button.setTitle(info.title, for: UIControlState())
      button.removeTarget(nil, action: nil, for: .allEvents)
      button.addTarget(self, action: info.action, for: .touchUpInside)
    } else {
      button.setTitle("Not Active", for: UIControlState())
      button.removeTarget(nil, action: nil, for: .allEvents)
    }
  }
}
