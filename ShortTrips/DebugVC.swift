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
  
  let tripManager = TripManager.sharedInstance
  
  var attemptingPingObserver: NotificationObserver<Ping, AnyObject>?
  var cidReadDetectedObserver: NotificationObserver<Cid, AnyObject>?
  var foundInsideGeofencesObserver: NotificationObserver<[Geofence], AnyObject>?
  var locationManagerStartedObserver: NotificationObserver<Any?, AnyObject>?
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  var responseObserver: NotificationObserver<NSHTTPURLResponse, AnyObject>?
  var successfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var entryGateAVI: NotificationObserver<Any?, AnyObject>?
  var driverAndVehicleAssociated: NotificationObserver<(driver: Driver, vehicle: Vehicle), AnyObject>?
  var startingToWait: NotificationObserver<Any?, AnyObject>?

  override func loadView() {
    let debugView = DebugView(frame: UIScreen.mainScreen().bounds)
    debugView.logOutButton.addTarget(self,
      action: "logout",
      forControlEvents: .TouchUpInside)
    view = debugView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    attemptingPingObserver = NotificationObserver(notification: SfoNotification.attemptingPing, handler: { ping, _ in
      self.debugView().printDebugLine("attempting ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    })
    
    foundInsideGeofencesObserver = NotificationObserver(notification: SfoNotification.foundInsideGeofences, handler: { geofences, _ in
      self.debugView().updateGeofenceList(geofences)
      for geofence in geofences {
        self.debugView().printDebugLine("in geofence: \(geofence.name)", type: .Positive)
      }
    })
    
    locationManagerStartedObserver = NotificationObserver(notification: SfoNotification.locationManagerStarted, handler: { _, _ in
      self.debugView().printDebugLine("started location manager", type: .BigDeal)
    })
    
    locationObserver = NotificationObserver(notification: SfoNotification.locationRead, handler: { location, _ in
      self.debugView().printDebugLine("read location: (\(location.coordinate.latitude), \(location.coordinate.longitude)) at \(location.timestamp)")
      self.debugView().updateGPS(location.coordinate.latitude, longitude: location.coordinate.longitude)
    })
    
    responseObserver = NotificationObserver(notification: SfoNotification.requestResponse, handler: { response, _ in
      self.debugView().printDebugLine("URL: \(response.URL!)\nstatusCode: \(response.statusCode)",
        type: StatusCode.isSuccessful(response.statusCode) ? .Positive : .Negative )
    })

    successfulPingObserver = NotificationObserver(notification: SfoNotification.successfulPing, handler: { ping, _ in
      self.debugView().printDebugLine("succesful ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    })

    entryGateAVI = NotificationObserver(notification: SfoNotification.entryGateAVI, handler: { cid, _ in
      self.debugView().printDebugLine("entry gate avi detected: (\(cid)")
    })

    driverAndVehicleAssociated = NotificationObserver(notification: SfoNotification.driverAndVehiculeAssociated, handler: { data, _ in
      let vehicle = data.vehicle
      let driver = data.driver
      
      self.debugView().printDebugLine("driver \(driver.firstName) \(driver.lastName) is associated with transponder: (\(vehicle.transponderId)")
    })
    
    startingToWait = NotificationObserver(notification: SfoNotification.startingToWait, handler: { foo, _ in
      self.debugView().printDebugLine("starting to wait")
    })
  }
  
  func debugView() -> DebugView {
    return self.view as! DebugView
  }
  
  func logout() {
    DriverCredential.clear()
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
}
