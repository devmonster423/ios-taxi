//
//  LocationManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
  
  let requiredAccuracy: CLLocationAccuracy = 100
  let manager = CLLocationManager()
  
  static let sharedInstance = LocationManager()
  
  private var lastKnownLocation: CLLocation?
  
  private var bgId: UIBackgroundTaskIdentifier?
  
  private override init() {
    super.init()
    
    NotificationCenter.default.addObserver(forName: .locRead, object: nil, queue: nil) { note in
      
      let location = note.userInfo![InfoKey.location] as! CLLocation
      self.lastKnownLocation = location
    }
  }
  
  func start() {
    
    if #available(iOS 9.0, *) {
      manager.allowsBackgroundLocationUpdates = true
    }
    
    // this might solve the "lunch issue"
    // manager.activityType = .AutomotiveNavigation
    manager.pausesLocationUpdatesAutomatically = false
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    manager.distanceFilter = kCLDistanceFilterNone
    manager.requestAlwaysAuthorization()
    manager.startUpdatingLocation()
    NotificationCenter.default.post(name: .locManagerStarted, object: nil)
  }
  
  func stop() {
    manager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    
    if self.bgId == nil {
      self.bgId = UIApplication.shared.beginBackgroundTask { _ in
        if let bgId = self.bgId {
          UIApplication.shared.endBackgroundTask(bgId)
          self.bgId = nil
        }
      }
    }
    
    if let location = locations.last {
      self.lastKnownLocation = location
      
      if location.horizontalAccuracy < requiredAccuracy {
        NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: location])
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didChangeAuthorization status: CLAuthorizationStatus) {
    
    NotificationCenter.default.post(name: .locStatusUpdated, object: nil, userInfo: [InfoKey.locationStatus: status])
    if status == .authorizedAlways {
      GpsEnabled.sharedInstance.fire()
    } else {
      GpsDisabled.sharedInstance.fire()
    }
  }
  
  func getLastKnownLocation() -> CLLocation? {
    return lastKnownLocation
  }
}
