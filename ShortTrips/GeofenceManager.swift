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
          self.process(geofences.map { geofence -> SfoGeofence in return geofence.geofence! })
          postNotification(SfoNotification.Geofence.foundInside, value: geofences)
        }
    }
  }

  private func process(geofences: [SfoGeofence]) {
    
    if geofences.contains(.Sfo) {
      InsideSfo.sharedInstance.fire()
    }
    
    if geofences.contains(.SfoInternationalExit) || geofences.contains(.SfoTaxiDomesticExit) {
      InsideTaxiLoopExit.sharedInstance.fire()
    }
    
    if geofences.contains(.SfoTerminalExit)
      && !geofences.contains(.SfoInternationalExit)
      && !geofences.contains(.SfoTaxiDomesticExit) {
      ExitingTerminals.sharedInstance.fire()
    }
    
    if !geofences.contains(.SfoTerminalExit) {
      NotInTerminalExit.sharedInstance.fire()
    }
  }
}
