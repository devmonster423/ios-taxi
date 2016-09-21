//
//  LocationManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

class LocationManager: NSObject, CLLocationManagerDelegate {
  
  let requiredAccuracy: CLLocationAccuracy = 100
  let manager = CLLocationManager()
  
  static let sharedInstance = LocationManager()
  
  fileprivate var lastKnownLocation: CLLocation?
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  
  fileprivate var bgId: UIBackgroundTaskIdentifier?
  
  fileprivate override init() {
    super.init()
    
    locationObserver = NotificationObserver(notification: SfoNotification.Location.read) { location, _ in
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
    postNotification(SfoNotification.Location.managerStarted, value: nil)
  }
  
  func stop() {
    manager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    
    if self.bgId == nil {
      self.bgId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { _ in
        if let bgId = self.bgId {
          UIApplication.sharedApplication().endBackgroundTask(bgId)
          self.bgId = nil
        }
      }
    }
    
    if let location = locations.last {
      self.lastKnownLocation = location
      
      if location.horizontalAccuracy < requiredAccuracy {
        postNotification(SfoNotification.Location.read, value: location)
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didChangeAuthorization status: CLAuthorizationStatus) {
    
    postNotification(SfoNotification.Location.statusUpdated, value: status)
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
