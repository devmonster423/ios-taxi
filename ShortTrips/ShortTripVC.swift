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
    
    setupAviObservers()
    setupCidObservers()
    setupDriverObservers()
    setupGeofenceObservers()
    setupLocationObservers()
    setupPingObservers()
    setupStateObservers()
    setupTripObservers()
  
    configureNavBar(Image.shortTripBackground.image(), back:false)
    addLogoutButton()
    
    updateForState(StateManager.sharedInstance.getMachine().currentState)
    
    if let tripTimer = tripTimer {
      tripTimer.invalidate()
    }
    
    tripTimer = NSTimer.scheduledTimerWithTimeInterval(60,
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
    if let elapsedTime = TripManager.sharedInstance.getElapsedTime() {
      let remainingTime = Int(2 * 60 * 60 - elapsedTime)
      let remainingHours = Int(remainingTime / (60 * 60))
      let remainingMinutes = Int((remainingTime - remainingHours * 60 * 60) / 60)
      shortTripView().countdownLabel.text = "  " + NSLocalizedString("Time Remaining", comment: "") + ": \(remainingHours)h \(remainingMinutes)m"
      print(NSLocalizedString("Time Remaining", comment: "") + ": \(remainingHours)h \(remainingMinutes)m")
    } else {
      shortTripView().countdownLabel.text = ""
    }
  }
}
