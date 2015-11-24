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

typealias ButtonUpdateInfo = (title: String, action: Selector)

class DebugVC: UIViewController {
  
  let stateManager = StateManager.sharedInstance // needed, to start the state machine
  
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
  var associatingDriverAndVehicleAtEntry: NotificationObserver<Any?, AnyObject>?
  var associatingDriverAndVehicleAtHoldingLotExit: NotificationObserver<Any?, AnyObject>?
  var enteredNotReadyState: NotificationObserver<Any?, AnyObject>?
  var enteredReadyState: NotificationObserver<Any?, AnyObject>?
  var inProgressState: NotificationObserver<Any?, AnyObject>?
  var startingToWaitInHoldingLot: NotificationObserver<Any?, AnyObject>?
  var validatingTrip: NotificationObserver<Any?, AnyObject>?
  var waitForEntryCidObserver: NotificationObserver<Any?, AnyObject>?
  var waitForEntryGateAviObserver: NotificationObserver<Any?, AnyObject>?
  var waitForPaymentCid: NotificationObserver<Any?, AnyObject>?
  var waitForExitAvi: NotificationObserver<Any?, AnyObject>?
  var waitForTaxiLoopAvi: NotificationObserver<Any?, AnyObject>?
  var waitForTripToStart: NotificationObserver<Any?, AnyObject>?
  var waitForInboundAvi: NotificationObserver<Any?, AnyObject>?
  
  // Trip
  var entryStepFailedObserver: NotificationObserver<Any?, AnyObject>?
  var inboundStepFailedObserver: NotificationObserver<Any?, AnyObject>?
  var timeExpiredObserver: NotificationObserver<Any?, AnyObject>?
  var tripStartedObserver: NotificationObserver<Int, AnyObject>?
  var validatedObserver: NotificationObserver<Any?, AnyObject>?
  var invalidatedObserver: NotificationObserver<[ValidationStepWrapper]?, AnyObject>?
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
    debugView.updateState("Not Ready")

    debugView.secondFakeButton.setTitle("Inside Taxi Loop Exit", forState: .Normal)
    debugView.secondFakeButton.addTarget(self,
      action: "triggerAtTerminalExit",
      forControlEvents: .TouchUpInside)
    
    debugView.thirdFakeButton.setTitle("Not Active", forState: .Normal)
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
