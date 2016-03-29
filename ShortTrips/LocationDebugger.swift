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
import Crashlytics

extension DebugVC {
  
  func setupLocationObservers() {
    sfoObservers.locationManagerStartedObserver = NotificationObserver(notification: SfoNotification.Location.managerStarted) { _, _ in
      self.debugView().printDebugLine("started location manager", type: .BigDeal)
    }
    
    sfoObservers.locationObserver = NotificationObserver(notification: SfoNotification.Location.read, handler: { location, _ in
      self.debugView().updateGPS(location.coordinate.latitude, longitude: location.coordinate.longitude)
    })

    sfoObservers.locationStatusObserver = NotificationObserver(notification: SfoNotification.Location.statusUpdated, handler: { status, _ in
      if status == .AuthorizedAlways {
        self.debugView().printDebugLine("location status updated: GPS on")
      } else {
        self.debugView().printDebugLine("location status updated: GPS off!")
      }
    })
  }
  
  func backToSFO() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.614695, longitude: -122.39468))
  }
  
  func fakeGpsOn() {
    Util.testingGps = true
    GpsEnabled.sharedInstance.fire()
  }
  
  func dropPassenger() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.622254, longitude: -122.409925))
    self.updateFakeButtons((title: "Back To SFO", action: #selector(DebugVC.backToSFO)),
      second: (title: "Turn Off Pings", action: #selector(DebugVC.turnOffPings)),
      third: (title: "Crash App", action: #selector(DebugVC.crash)))
  }
  
  func fakeExitingTerminals() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.615119, longitude: -122.393328))
  }
  
  func fakeOutsideGeofences() {
    
    if let medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion,
      let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId,
      let tripId = TripManager.sharedInstance.getTripId() {
    
      let ping = Ping(location: CLLocation(latitude: 37.760661, longitude: -122.434092),
        tripId: tripId,
        vehicleId: 123,
        sessionId: sessionId,
        medallion: medallion)
      
      postNotification(SfoNotification.Ping.created, value: ping)
    }
  }
  
  func crash() {
    if Util.debug {
      Crashlytics.sharedInstance().crash()
    }
  }
  
  func triggerOutsideDomesticTerminalExit() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.614319, longitude: -122.390206))
  }
  
  func triggerAtIntlTerminal() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.6149, longitude: -122.39))
  }
  
  func triggerAtTerminalExit() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.6168, longitude: -122.3843))
  }
  
  func triggerInsideSfo() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.621313, longitude: -122.378955))
  }
  
  func triggerInsideTaxiWaitingZone() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.616424, longitude: -122.386107))
  }
  
  func triggerOutsideTaxiWaitingZone() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.621313, longitude: -122.378955))
  }
  
  func triggerAtDomesticDropoff() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.615943, longitude: -122.384233))
  }
  
  func inDomExit() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.616798, longitude: -122.384317))
  }
  
  func inIntlExit() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.615149, longitude: -122.390133))
  }
  
  func outOfBufferedExit() {
    Util.testingGps = true
    postNotification(SfoNotification.Location.read, value: CLLocation(latitude: 37.616489, longitude: -122.398215))
  }
}
