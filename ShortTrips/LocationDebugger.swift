//
//  LocationDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupLocationObservers() {
    locationManagerStartedObserver = NotificationObserver(notification: SfoNotification.Location.managerStarted) { _, _ in
      self.debugView().printDebugLine("started location manager", type: .BigDeal)
    }
    
    locationObserver = NotificationObserver(notification: SfoNotification.Location.read, handler: { location, _ in
      self.debugView().printDebugLine("read location: (\(location.coordinate.latitude), \(location.coordinate.longitude)) at \(location.timestamp)")
      self.debugView().updateGPS(location.coordinate.latitude, longitude: location.coordinate.longitude)
    })

    locationStatusObserver = NotificationObserver(notification: SfoNotification.Location.statusUpdated, handler: { status, _ in
      if status == .AuthorizedAlways {
        self.debugView().printDebugLine("location status updated: GPS on")
      } else {
        self.debugView().printDebugLine("location status updated: GPS off!")
      }
    })
  }
  
  func backToSFO() {
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.621313, longitude: -122.378955))
  }
  
  func dropPassenger() {
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.622254, longitude: -122.409925))
    self.updateFakeButtons((title: "Back To SFO", action: "backToSFO"))
  }
  
  func fakeExitingTerminals() {
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.615119, longitude: -122.393328))
  }
  
  func fakeOutsideGeofences() {
    
    let medallion = DriverManager.sharedInstance.getCurrentVehicle()!.medallion
    let sessionId = DriverManager.sharedInstance.getCurrentDriver()!.sessionId
    let tripId = TripManager.sharedInstance.getTripId()!
    
    postNotification(SfoNotification.Ping.created, value: (ping: Ping(location: CLLocation(latitude: 37.760661, longitude: -122.434092), tripId: tripId, sessionId: sessionId, medallion: medallion), geofenceStatus: FoundGeofenceStatus(status: .Invalid, geofence: nil)))
  }
  
  func triggerAtTerminalExit() {
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.615319, longitude: -122.390206))
  }
  
  func triggerInsideSfo() {
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.621313, longitude: -122.378955))
  }
  
  func triggerOutsideSfo() {
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.610560, longitude: -122.393328))
  }
}
