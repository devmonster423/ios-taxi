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
  let stateManager = StateManager.sharedInstance // needed, to start the state machine
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
    updateForState(StateManager.sharedInstance.getMachine().currentState)
  }
  
  func shortTripView() -> ShortTripView {
    return self.view as! ShortTripView
  }
  
  func logout() {
    LoggedOut.sharedInstance.fire()
    DriverCredential.clear()
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
}
