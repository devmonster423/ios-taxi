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

class GeofenceManager: NSObject {
  
  let updateFrequency = NSTimeInterval(30)

  static let sharedInstance = GeofenceManager()
  
  private var timer: NSTimer?

  func start() {
    if let _ = timer {} else {
      timer = NSTimer.scheduledTimerWithTimeInterval(updateFrequency,
        target: self,
        selector: "processLastKnownLocation",
        userInfo: nil,
        repeats: true)
    }
  }

  func stop() {
    timer?.invalidate()
    timer = nil
  }
  
  func processLastKnownLocation() {
    if let location = LocationManager.sharedInstance.getLastKnownLocation() {
      ApiClient.requestGeofencesForLocation(location.coordinate.latitude,
        longitude: location.coordinate.longitude,
        buffer: GeofenceArbiter.buffer) { geofences in
          
          if let geofences = geofences {
            self.process(geofences.flatMap { geofence -> SfoGeofence? in return geofence.geofence })
            postNotification(SfoNotification.Geofence.foundInside, value: geofences)
          }
      }
    }
  }

  private func process(geofences: [SfoGeofence]) {
    
    if geofences.contains(.Sfo) {
      InsideSfo.sharedInstance.fire()
    } else {
      OutsideSfo.sharedInstance.fire()
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
