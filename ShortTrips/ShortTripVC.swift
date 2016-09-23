//
//  ShortTripVC.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import CoreLocation

class ShortTripVC: UIViewController {
  private var tripTimer: Timer?
  
  override func loadView() {
    let shortTripView = ShortTripView(frame: UIScreen.main.bounds)
    shortTripView.setReachabilityNoticeHidden(ReachabilityManager.sharedInstance.isReachable())
    view = shortTripView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupObservers()
  
    configureNavBar(title: NSLocalizedString("Trip Status", comment: "").uppercased())
    addSettingsButton()
    
    initializeForState(StateManager.sharedInstance.getMachine().currentState)
    
    if let tripTimer = tripTimer {
      tripTimer.invalidate()
    }
    
    tripTimer = Timer.scheduledTimer(timeInterval: 1,
      target: self,
      selector: #selector(ShortTripVC.checkTime),
      userInfo: nil,
      repeats: true)
    
    checkTime()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    shortTripView().skipAnyPendingNotifications()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if let tripId = PendingAppQuit.get() {
      AppQuit.sharedInstance.fire(tripId)
    }
  }
  
  func shortTripView() -> ShortTripView {
    return self.view as! ShortTripView
  }
  
  func checkTime() {
    shortTripView().updateCountdown(TripManager.sharedInstance.getElapsedTime())
  }
}
