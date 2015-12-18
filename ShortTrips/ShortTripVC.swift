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
  
  override func loadView() {
    let shortTripView = ShortTripView(frame: UIScreen.mainScreen().bounds)
    shortTripView.logOutButton.addTarget(self, action: "logout", forControlEvents: .TouchUpInside)
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
    setupRequestObservers()
    setupStateObservers()
    setupTripObservers()
  
    configureNavBar()
    
    updateForState(StateManager.sharedInstance.getMachine().currentState)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    configureTitle()
  }
  
  func shortTripView() -> ShortTripView {
    return self.view as! ShortTripView
  }
}
