//
//  ShortTripVC.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import CoreLocation
import JSQNotificationObserverKit

class ShortTripVC: UIViewController {
  var sfoObservers = SfoObservers()
  private var tripTimer: NSTimer?
  
  override func loadView() {
    let shortTripView = ShortTripView(frame: UIScreen.mainScreen().bounds)
    view = shortTripView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupObservers()
  
    configureNavBar(back:false, title: NSLocalizedString("Trip Status", comment: "").uppercaseString)
    addLogoutButton()
    
    updateForState(StateManager.sharedInstance.getMachine().currentState)
    
    if let tripTimer = tripTimer {
      tripTimer.invalidate()
    }
    
    tripTimer = NSTimer.scheduledTimerWithTimeInterval(1,
      target: self,
      selector: "checkTime",
      userInfo: nil,
      repeats: true)
    
    checkTime()
  }
  
  func shortTripView() -> ShortTripView {
    return self.view as! ShortTripView
  }
  
  func checkTime() {
    shortTripView().updateCountdown(TripManager.sharedInstance.getElapsedTime())
  }
}
