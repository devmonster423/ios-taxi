//
//  LocationManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
  func readLocation(location: CLLocation)
  func attemptingPingAtLocation(ping: Ping)
  func successfulPingAtLocation(ping: Ping)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
  
  var delegate: LocationManagerDelegate?
  var lastSuccessfulPingDate: NSDate?
  var updateFrequency = NSTimeInterval(60)
  
  let manager = CLLocationManager()
  
  static let sharedInstance = LocationManager()
  
  private override init() {
    super.init()
    
    manager.activityType = .AutomotiveNavigation
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestAlwaysAuthorization()
    manager.startUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
      
      delegate?.readLocation(locations.last!)
      
      var pingDate = NSDate(timeIntervalSince1970: 0)
      if let lastSuccessfulPingDate = lastSuccessfulPingDate {
        pingDate = lastSuccessfulPingDate
      }
      
      if pingDate.timeIntervalSinceNow < -updateFrequency,
        let lastKnownLocation = locations.last,
        let tripId = TripManager.sharedInstance.getTripId() {
          
          let ping = Ping(location: lastKnownLocation)
          self.delegate?.attemptingPingAtLocation(ping)
          
          ApiClient.ping(tripId, ping: ping, response: { geofenceStatus in
            
            if let _ = geofenceStatus {
              self.lastSuccessfulPingDate = NSDate()
              self.delegate?.successfulPingAtLocation(ping)
            }
          })
      }
  }
}
