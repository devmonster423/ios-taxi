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
    manager.desiredAccuracy = 100
    manager.distanceFilter = 100
    manager.requestAlwaysAuthorization()
    manager.startUpdatingLocation()
    postNotification(SfoNotification.Location.managerStarted, value: nil)
  }

  func stop() {
    manager.stopUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
      postNotification(SfoNotification.Location.read, value: locations.last!)
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
}
