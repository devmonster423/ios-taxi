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

  private var lastKnownLocation: CLLocation?
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  
  private override init() {
    super.init()
    
    locationObserver = NotificationObserver(notification: SfoNotification.Location.read) { location, _ in
      self.lastKnownLocation = location
    }
  }

  func start() {
    manager.activityType = .AutomotiveNavigation
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
  
  func locationManager(manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
      if let location = locations.last where location.horizontalAccuracy < requiredAccuracy {
        postNotification(SfoNotification.Location.read, value: location)
      }
  }

  func locationManager(manager: CLLocationManager,
    didChangeAuthorizationStatus status: CLAuthorizationStatus){
      
      postNotification(SfoNotification.Location.statusUpdated, value: status)
      if status != .AuthorizedAlways {
        GpsDisabled.sharedInstance.fire()
      }
  }

  func getLastKnownLocation() -> CLLocation? {
    return lastKnownLocation
  }
  
  static func locationActiveAndAuthorized() -> Bool {
    if Util.testing() {
      return true
    } else {
      return CLLocationManager.locationServicesEnabled()
        && CLLocationManager.authorizationStatus() == .AuthorizedAlways
    }
  }
}
