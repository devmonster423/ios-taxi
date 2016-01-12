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
  private var numberFormatter: NSNumberFormatter {
    let formatter = NSNumberFormatter()
    formatter.minimumIntegerDigits = 2
    return formatter
  }
  
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
    if let elapsedTime = TripManager.sharedInstance.getElapsedTime() {
      let remainingTime = Int(2 * 60 * 60 - elapsedTime)
      let remainingHours = Int(remainingTime / (60 * 60))
      let remainingMinutes = Int((remainingTime - remainingHours * 60 * 60) / 60)
      let remainingSeconds = Int(remainingTime - remainingHours * 60 * 60 - remainingMinutes * 60)
      
      shortTripView().countdownLabel.text = "\(remainingHours)h \(numberFormatter.stringFromNumber(remainingMinutes)!)m \(numberFormatter.stringFromNumber(remainingSeconds)!)s"
    } else {
      shortTripView().countdownLabel.text = ""
    }
  }
}
