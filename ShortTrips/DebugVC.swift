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
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  var attemptingPingObserver: NotificationObserver<Ping, AnyObject>?
  var successfulPingObserver: NotificationObserver<Ping, AnyObject>?

  override func loadView() {
    let debugView = DebugView(frame: UIScreen.mainScreen().bounds)
    debugView.logOutButton.addTarget(self,
      action: "logout",
      forControlEvents: .TouchUpInside)
    view = debugView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    debugView().printDebugLine("started location manager", type: .BigDeal)

    // register observers
    locationObserver = NotificationObserver(notification: LocationRead.notification(), handler: { location, _ in
      self.readLocation(location)
    })

    attemptingPingObserver = NotificationObserver(notification: AttemptingPing.notification(), handler: { ping, _ in
      self.attemptingPingAtLocation(ping)
    })

    successfulPingObserver = NotificationObserver(notification: SuccessfulPing.notification(), handler: { ping, _ in
      self.successfulPingAtLocation(ping)
    })
  }
  
  func debugView() -> DebugView {
    return self.view as! DebugView
  }
  
  func logout() {
    DriverCredential.clear()
    self.navigationController?.popToRootViewControllerAnimated(true)
  }

  func readLocation(location: CLLocation) {
    debugView().printDebugLine("read location: (\(location.coordinate.latitude), \(location.coordinate.longitude)) at \(location.timestamp)")
    debugView().updateGPS(location.coordinate.latitude, longitude: location.coordinate.longitude)
    
    ApiClient.requestGeofencesForLocation(location.coordinate.latitude,
      longitude: location.coordinate.longitude,
      buffer: GeofenceArbiter.buffer) { geofences in
        if let geofences = geofences {
          self.debugView().updateGeofenceList(geofences)
          GeofenceArbiter.processGeofences(geofences)
          for geofence in geofences {
            self.debugView().printDebugLine("in geofence: \(geofence.name)", type: .Positive)
          }
        }
    }
  }
  
  func attemptingPingAtLocation(ping: Ping) {
    debugView().printDebugLine("attempting ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
  }
  
  func successfulPingAtLocation(ping: Ping) {
    debugView().printDebugLine("succesful ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
  }
}
