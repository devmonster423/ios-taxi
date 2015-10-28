//
//  GeofenceManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

class GeofenceManager {

  var locationObserver: NotificationObserver<CLLocation, AnyObject>?

  static let sharedInstance = GeofenceManager()

  private init() {}

  func start() {
    if let _ = locationObserver {} else {
      self.locationObserver = NotificationObserver(notification: SfoNotification.Location.read, handler: { location, _ in
        self.process(location)
      })
    }
  }

  func stop() {
    locationObserver = nil
  }

  private func process(location: CLLocation) {
    ApiClient.requestGeofencesForLocation(location.coordinate.latitude,
      longitude: location.coordinate.longitude,
      buffer: GeofenceArbiter.buffer) { geofences in
        if let geofences = geofences {
          postNotification(SfoNotification.Geofence.foundInside, value: geofences)
          self.process(geofences)
        }
    }
  }

  private func process(geofences: [Geofence]) {
  
    var driverInsideSfo = false
    
    for geofence in geofences {
      if let identifiedGeofence = SfoGeofence.find(geofence) {
        switch identifiedGeofence {
        case .SFO:
          EnteredSFOGeofence.sharedInstance.fire()
          driverInsideSfo = true
        case .SfoTerminalExit:
          InsideTaxiLoopExit.sharedInstance.fire()
        }
      }
    }
    
    if !driverInsideSfo{
      DriverOutsideSfo.sharedInstance.fire()
    }
  }
  
}
