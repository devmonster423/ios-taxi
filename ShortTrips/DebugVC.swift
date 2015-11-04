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

class DebugVC: UIViewController {
  
  let stateManager = StateManager.sharedInstance // needed, to start the state machine
  
  // Avi
  var entryGateAvi: NotificationObserver<Antenna, AnyObject>?
  var taxiLoopAviRead: NotificationObserver<Antenna, AnyObject>?
  var exitAviRead:  NotificationObserver<Antenna, AnyObject>?
  
  // Cid
  var entryCidRead: NotificationObserver<Cid, AnyObject>?
  var paymentCidRead: NotificationObserver<Cid, AnyObject>?
  
  // Driver
  var driverAndVehicleAssociated: NotificationObserver<(driver: Driver, vehicle: Vehicle), AnyObject>?
  
  // Geofence
  var foundInsideGeofencesObserver: NotificationObserver<[Geofence], AnyObject>?
  var insideSfoObserver: NotificationObserver<Any?, AnyObject>?
  var outsideSfoObserver: NotificationObserver<Any?, AnyObject>?
  
  // Location
  var locationManagerStartedObserver: NotificationObserver<Any?, AnyObject>?
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  
  // Ping
  var attemptingPingObserver: NotificationObserver<Ping, AnyObject>?
  var invalidPingObserver: NotificationObserver<Ping, AnyObject>?
  var successfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var unsuccessfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var validPingObserver: NotificationObserver<Ping, AnyObject>?
  
  // Request
  var responseObserver: NotificationObserver<NSHTTPURLResponse, AnyObject>?
  
  // State
  var associatingDriverAndVehicle: NotificationObserver<Any?, AnyObject>?
  var enteredNotReadyState: NotificationObserver<Any?, AnyObject>?
  var enteredReadyState: NotificationObserver<Any?, AnyObject>?
  var inProgressState: NotificationObserver<Any?, AnyObject>?
  var startingToWait: NotificationObserver<Any?, AnyObject>?
  var waitForEntryCidObserver: NotificationObserver<Any?, AnyObject>?
  var waitForEntryGateAviObserver: NotificationObserver<Any?, AnyObject>?
  var waitForPaymentCid: NotificationObserver<Any?, AnyObject>?
  
  // Trip
  var timeExpiredObserver: NotificationObserver<Any?, AnyObject>?
  var tripStartedObserver: NotificationObserver<Int, AnyObject>?
  var validationObserver: NotificationObserver<Bool, AnyObject>?
  var warningObserver: NotificationObserver<TripWarning, AnyObject>?

  override func loadView() {
    let debugView = DebugView(frame: UIScreen.mainScreen().bounds)
    debugView.logOutButton.addTarget(self,
      action: "logout",
      forControlEvents: .TouchUpInside)
    debugView.fakeButton.setTitle("Fake Inside SFO", forState: .Normal)
    debugView.fakeButton.addTarget(self,
      action: "triggerInsideSfo",
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
  }
  
  func debugView() -> DebugView {
    return self.view as! DebugView
  }
  
  func logout() {
    DriverCredential.clear()
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  func updateFakeButton(title: String, action: Selector){
    self.debugView().fakeButton.setTitle(title, forState: .Normal)
    self.debugView().fakeButton.removeTarget(nil,
      action: nil,
      forControlEvents: .AllEvents)
    self.debugView().fakeButton.addTarget(self,
      action: action,
      forControlEvents: .TouchUpInside)
  }
}
