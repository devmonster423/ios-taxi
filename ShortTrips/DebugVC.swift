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
  
  let stateManager = StateManager.sharedInstance
  
  var attemptingPingObserver: NotificationObserver<Ping, AnyObject>?
  var cidReadDetectedObserver: NotificationObserver<Cid, AnyObject>?
  var foundInsideGeofencesObserver: NotificationObserver<[Geofence], AnyObject>?
  var locationManagerStartedObserver: NotificationObserver<Any?, AnyObject>?
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  var responseObserver: NotificationObserver<NSHTTPURLResponse, AnyObject>?
  var successfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var unsuccessfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var validPingObserver: NotificationObserver<Ping, AnyObject>?
  var invalidPingObserver: NotificationObserver<Ping, AnyObject>?
  var entryGateAVI: NotificationObserver<Antenna, AnyObject>?
  var driverAndVehicleAssociated: NotificationObserver<(driver: Driver, vehicle: Vehicle), AnyObject>?
  var startingToWait: NotificationObserver<Any?, AnyObject>?
  var paymentCidRead: NotificationObserver<Cid, AnyObject>?
  var taxiLoopAVIRead: NotificationObserver<Antenna, AnyObject>?
  var enteredNotReadyState: NotificationObserver<Any?, AnyObject>?
  var enteredReadyState: NotificationObserver<Any?, AnyObject>?
  var inProgressState: NotificationObserver<Any?, AnyObject>?
  var tripStartedObserver: NotificationObserver<Int, AnyObject>?
  var timeExpiredObserver: NotificationObserver<Any?, AnyObject>?
  var warningObserver: NotificationObserver<TripWarning, AnyObject>?
  var validationObserver: NotificationObserver<Bool, AnyObject>?
  var waitForEntryCidObserver: NotificationObserver<Any?, AnyObject>?
  var insideSfoObserver: NotificationObserver<Any?, AnyObject>?
  var outsideSfoObserver: NotificationObserver<Any?, AnyObject>?
  var associatingDriverAndVehicle: NotificationObserver<Any?, AnyObject>?

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

    attemptingPingObserver = NotificationObserver(notification: SfoNotification.Ping.attempting, handler: { ping, _ in
      self.debugView().printDebugLine("attempting ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    })
    
    foundInsideGeofencesObserver = NotificationObserver(notification: SfoNotification.Geofence.foundInside, handler: { geofences, _ in
      self.debugView().updateGeofenceList(geofences)
      for geofence in geofences {
        self.debugView().printDebugLine("in geofence: \(geofence.name)", type: .Positive)
      }
    })
    
    locationManagerStartedObserver = NotificationObserver(notification: SfoNotification.Location.managerStarted, handler: { _, _ in
      self.debugView().printDebugLine("started location manager", type: .BigDeal)
      self.updateFakeButton("Fake Inside SFO", action: "triggerInsideSfo")
    })
    
    locationObserver = NotificationObserver(notification: SfoNotification.Location.read, handler: { location, _ in
      self.debugView().printDebugLine("read location: (\(location.coordinate.latitude), \(location.coordinate.longitude)) at \(location.timestamp)")
      self.debugView().updateGPS(location.coordinate.latitude, longitude: location.coordinate.longitude)
    })
    
    responseObserver = NotificationObserver(notification: SfoNotification.Request.response, handler: { response, _ in
      self.debugView().printDebugLine("URL: \(response.URL!)\nstatusCode: \(response.statusCode)",
        type: StatusCode.isSuccessful(response.statusCode) ? .Positive : .Negative )
    })

    successfulPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.debugView().printDebugLine("successful ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    })
    
    unsuccessfulPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.debugView().printDebugLine("unsuccessful ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)", type: .Negative)
    })
    
    validPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.debugView().printDebugLine("valid ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    })
    
    invalidPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.debugView().printDebugLine("invalid ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)", type: .Negative)
    })

    entryGateAVI = NotificationObserver(notification: SfoNotification.Avi.entryGate, handler: { antenna, _ in
      self.debugView().printDebugLine("entry gate avi detected: (\(antenna)")
      self.updateFakeButton("Fake At Terminal Exit", action: "triggerAtTerminalExit")
    })

    driverAndVehicleAssociated = NotificationObserver(notification: SfoNotification.Driver.vehicleAssociated, handler: { data, _ in
      let vehicle = data.vehicle
      let driver = data.driver
      
      self.debugView().printDebugLine("driver \(driver.firstName) \(driver.lastName) is associated with transponder: (\(vehicle.transponderId)")
      self.updateFakeButton("Confirm Entry Gate Avi Read", action: "confirmEntryGateAviRead")
    })
    
    startingToWait = NotificationObserver(notification: SfoNotification.State.wait, handler: { _, _ in
      self.debugView().printDebugLine("starting to wait")
    })

    paymentCidRead = NotificationObserver(notification: SfoNotification.Cid.payment, handler: { cid, _ in
      self.debugView().printDebugLine("payment cid read detected: (\(cid)")
      self.updateFakeButton("Latest Avi Read At Taxi Loop", action: "latestAviReadAtTaxiLoop")
    })

    taxiLoopAVIRead = NotificationObserver(notification: SfoNotification.Avi.taxiLoop, handler: { antenna, _ in
      self.debugView().printDebugLine("Taxiloop AVI read: (\(antenna)")
      self.updateFakeButton("Fake Cid Payment", action: "fakeCidPayment")
    })
    
    enteredNotReadyState = NotificationObserver(notification: SfoNotification.State.notReady, handler: { _, _ in
      self.debugView().printDebugLine("Entered Not Ready State")
    })
    
    enteredReadyState = NotificationObserver(notification: SfoNotification.State.ready, handler: { _, _ in
      self.debugView().printDebugLine("Entered Ready State")
      self.updateFakeButton("Start Ride", action: "leaveTerminalExitLoop")
    })
    
    inProgressState = NotificationObserver(notification: SfoNotification.State.inProgress, handler: { _, _ in
      self.debugView().printDebugLine("Entered InProgress State")
    })
    
    tripStartedObserver = NotificationObserver(notification: SfoNotification.Trip.started) { tripId, _ in
      self.debugView().printDebugLine("Trip started: \(tripId)", type: .Positive)
    }
    
    timeExpiredObserver = NotificationObserver(notification: SfoNotification.Trip.timeExpired) { _, _ in
      self.debugView().printDebugLine("Time Expired")
    }
    
    warningObserver = NotificationObserver(notification: SfoNotification.Trip.warning) { warning, _ in
      self.debugView().printDebugLine("Trip Warning: \(warning.rawValue)")
    }
    
    validationObserver = NotificationObserver(notification: SfoNotification.Trip.validation) { valid, _ in
      if valid {
        self.debugView().printDebugLine("Trip is valid", type: .Positive)
      } else {
        self.debugView().printDebugLine("Trip is invalid", type: .Negative)
      }
    }
    
    waitForEntryCidObserver = NotificationObserver(notification: SfoNotification.State.waitForEntryCid, handler: { (value, sender) -> Void in
      self.updateFakeButton("Trigger Cid Entry", action: "triggerEntryCid")
    })
    
    insideSfoObserver = NotificationObserver(notification: SfoNotification.Geofence.insideSfo, handler: { (value, sender) -> Void in
      
      self.debugView().printDebugLine("inside SFO event!", type: .Positive)
    })
    
    outsideSfoObserver = NotificationObserver(notification: SfoNotification.Geofence.outsideSfo, handler: { (value, sender) -> Void in
      self.debugView().printDebugLine("outside SFO event!", type: .Positive)
    })
    
    associatingDriverAndVehicle = NotificationObserver(notification: SfoNotification.State.associatingDriverAndVehicle, handler: { _, _ in
      self.debugView().printDebugLine("Associating Driver And Vehicle")
      self.updateFakeButton("Associate Driver And Vehicle", action: "associateDriverAndVehicle")
    })
  }
  
  func debugView() -> DebugView {
    return self.view as! DebugView
  }
  
  func logout() {
    DriverCredential.clear()
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  
  
  
  
  func triggerInsideSfo() {
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.6132659912109, longitude: -122.400527954102))
  }
  
  func triggerEntryCid() {
    LatestCidIsEntryCid.sharedInstance.fire()
  }

  func associateDriverAndVehicle() {
    let vehicle = Vehicle(vehicleId: 123, transponderId: "what")
    DriverManager.sharedInstance.setCurrentVehicle(vehicle)
  }
  
  func confirmEntryGateAviRead() {
    EntryGateAVIReadConfirmed.sharedInstance.fire(Antenna(antennaId: 123, aviLocation: .Entry, aviDate: NSDate()))
  }
  
  func triggerAtTerminalExit() {
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.615319, longitude: -122.390206))
  }
  
  func fakeCidPayment(){
    let cid = Cid(cidId: 12, cidLocation: "Payment Gate")
    LatestCidIsPaymentCid.sharedInstance.fire(cid)
  }
  
  func latestAviReadAtTaxiLoop(){
    LatestAviReadAtTaxiLoop.sharedInstance.fire(Antenna(antennaId: 123, aviLocation: .Entry, aviDate: NSDate()))
  }

  func leaveTerminalExitLoop(){
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.610560, longitude: -122.401814))
    self.updateFakeButton("Drop Off Passenger", action: "dropPassenger")
  }

  func dropPassenger(){
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.622254, longitude: -122.409925))
    self.updateFakeButton("Back To SFO", action: "backToSFO")
  }
  
  func backToSFO(){
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.621313, longitude: -122.378955))
    
    self.updateFakeButton("NEXT", action: "")
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
