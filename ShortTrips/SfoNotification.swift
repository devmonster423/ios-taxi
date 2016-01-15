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
import TransitionKit

struct SfoNotification {
  struct Avi {
    static let domesticReEntry = Notification<Antenna, AnyObject>(name: "DomesticReEntryGateAvi")
    static let entryGate = Notification<Antenna, AnyObject>(name: "EntryGateAvi")
    static let domExit = Notification<Antenna, AnyObject>(name: "DomExitAvi")
    static let intlArrivalExit = Notification<Antenna, AnyObject>(name: "IntlArrivalExitAvi")
    static let taxiLoop = Notification<Antenna, AnyObject>(name: "TaxiLoopAviRead")
    static let unexpected = Notification<(expected: GtmsLocation, found: GtmsLocation), AnyObject>(name: "UnexpectedAvi")
  }

  struct Cid {
    static let entry = Notification<ShortTrips.Cid, AnyObject>(name: "EntryCidRead")
    static let payment = Notification<ShortTrips.Cid, AnyObject>(name: "PaymentCidRead")
    static let unexpected = Notification<(expected: GtmsLocation, found: GtmsLocation), AnyObject>(name: "UnexpectedCid")
  }
  
  struct Driver {
    static let logout = Notification<Any?, AnyObject>(name: "Logout")
    static let vehicleAssociated = Notification<(driver: ShortTrips.Driver, vehicle: Vehicle), AnyObject>(name: "DriverAndVehicleAssociated")
  }
  
  struct Geofence {
    static let foundInside = Notification<[SfoGeofence], AnyObject>(name: "FoundInsideGeofences")
    static let notInTerminalExit = Notification<Any?, AnyObject>(name: "NotInTerminalExit")
    static let outsideShortTrip = Notification<Any?, AnyObject>(name: "OutsideShortTrip")
  }
  
  struct Location {
    static let managerStarted = Notification<Any?, AnyObject>(name: "LocationManagerStarted")
    static let read = Notification<CLLocation, AnyObject>(name: "LocationRead")
    static let statusUpdated = Notification<CLAuthorizationStatus, AnyObject>(name: "LocationStatusUpdated")
  }
  
  struct Ping {
    static let attempting = Notification<ShortTrips.Ping, AnyObject>(name: "AttemptingPing")
    static let created = Notification<ShortTrips.Ping, AnyObject>(name: "CreatedPing")
    static let valid = Notification<ShortTrips.Ping, AnyObject>(name: "validPing")
    static let invalid = Notification<ShortTrips.Ping, AnyObject>(name: "invalidPing")
  }
  
  struct Request {
    static let response = Notification<NSHTTPURLResponse, AnyObject>(name: "RequestResponse")
  }
  
  struct State {
    static let update = Notification<TKState, AnyObject>(name: "StateUpdate")
  }
  
  struct Trip {
    static let invalidated = Notification<[ValidationStepWrapper]?, AnyObject>(name: "TripInvalidated")
    static let started = Notification<Int, AnyObject>(name: "TripStarted")
    static let timeExpired = Notification<Any?, AnyObject>(name: "TripTimeExpired")
    static let validated = Notification<Any?, AnyObject>(name: "TripValidated")
    static let warning = Notification<TripWarning, AnyObject>(name: "TripWarning")
  }
}
