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
  
  // Avi
  var entryGateAvi: NotificationObserver<Antenna, AnyObject>?
  var exitAviRead: NotificationObserver<Antenna, AnyObject>?
  var inboundAviRead: NotificationObserver<Antenna, AnyObject>?
  var taxiLoopAviRead: NotificationObserver<Antenna, AnyObject>?
  var unexpectedAviRead: NotificationObserver<(expected: GtmsLocation, found: GtmsLocation), AnyObject>?
  
  // Cid
  var entryCidRead: NotificationObserver<Cid, AnyObject>?
  var paymentCidRead: NotificationObserver<Cid, AnyObject>?
  var unexpectedCidRead: NotificationObserver<(expected: GtmsLocation, found: GtmsLocation), AnyObject>?
  
  // Driver
  var driverAndVehicleAssociated: NotificationObserver<(driver: Driver, vehicle: Vehicle), AnyObject>?
  
  // Geofence
  var exitingTerminalsObserver: NotificationObserver<Any?, AnyObject>?
  var foundInsideGeofencesObserver: NotificationObserver<[Geofence], AnyObject>?
  var insideSfoObserver: NotificationObserver<Any?, AnyObject>?
  var notInTerminalExitObserver: NotificationObserver<Any?, AnyObject>?
  var outsideShortTripObserver: NotificationObserver<Any?, AnyObject>?
  
  // Location
  var locationManagerStartedObserver: NotificationObserver<Any?, AnyObject>?
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  var locationStatusObserver: NotificationObserver<CLAuthorizationStatus, AnyObject>?
  
  // Ping
  var attemptingPingObserver: NotificationObserver<Ping, AnyObject>?
  var invalidPingObserver: NotificationObserver<Ping, AnyObject>?
  var successfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var unsuccessfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var validPingObserver: NotificationObserver<Ping, AnyObject>?
  
  // Request
  var responseObserver: NotificationObserver<NSHTTPURLResponse, AnyObject>?
  
  // State
  var stateUpdateObserver: NotificationObserver<TKState, AnyObject>?
  
  // Trip
  var invalidatedObserver: NotificationObserver<[ValidationStepWrapper]?, AnyObject>?
  var optionalEntryStepFailedObserver: NotificationObserver<Any?, AnyObject>?
  var reEntryAviFailedObserver: NotificationObserver<Any?, AnyObject>?
  var timeExpiredObserver: NotificationObserver<Any?, AnyObject>?
  var tripStartedObserver: NotificationObserver<Int, AnyObject>?
  var validatedObserver: NotificationObserver<Any?, AnyObject>?
  var warningObserver: NotificationObserver<TripWarning, AnyObject>?

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
  
  func logout() {
    LoggedOut.sharedInstance.fire()
    DriverCredential.clear()
    self.navigationController?.popToRootViewControllerAnimated(true)
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
