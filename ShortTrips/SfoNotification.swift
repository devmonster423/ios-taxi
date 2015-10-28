//
//  Notification.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit

struct SfoNotification {
  struct Avi {
    static let entryGate = Notification<Any?, AnyObject>(name: "EntryGateAvi")
    static let taxiLoop = Notification<Any?, AnyObject>(name: "TaxiLoopAVIRead")
  }

  struct Cid {
    static let payment = Notification<Any?, AnyObject>(name: "PaymentCidRead")
  }
  
  struct Driver {
    static let vehicleAssociated = Notification<(driver: ShortTrips.Driver, vehicle: Vehicle), AnyObject>(name: "DriverAndVehicleAssociated")
  }
  
  struct Geofence {
    static let foundInside = Notification<[ShortTrips.Geofence], AnyObject>(name: "FoundInsideGeofences")
  }
  
  struct Location {
    static let managerStarted = Notification<Any?, AnyObject>(name: "LocationManagerStarted")
    static let read = Notification<CLLocation, AnyObject>(name: "LocationRead")
  }
  
  struct Ping {
    static let attempting = Notification<ShortTrips.Ping, AnyObject>(name: "AttemptingPing")
    static let successful = Notification<ShortTrips.Ping, AnyObject>(name: "SuccessfulPing")
  }
  
  struct Request {
    static let response = Notification<NSHTTPURLResponse, AnyObject>(name: "RequestResponse")
  }
  
  struct State {
    static let wait = Notification<Any?, AnyObject>(name: "startingToWait")
    static let ready = Notification<Any?, AnyObject>(name: "EnteredReadyState")
  }
}
