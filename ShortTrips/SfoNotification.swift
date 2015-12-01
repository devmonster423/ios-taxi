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
    static let entryGate = Notification<Antenna, AnyObject>(name: "EntryGateAvi")
    static let exit = Notification<Antenna, AnyObject>(name: "ExitAvi")
    static let inbound = Notification<Antenna, AnyObject>(name: "InboundAvi")
    static let taxiLoop = Notification<Antenna, AnyObject>(name: "TaxiLoopAviRead")
    static let unexpected = Notification<(expected: GtmsLocation, found: GtmsLocation), AnyObject>(name: "UnexpectedAvi")
  }

  struct Cid {
    static let entry = Notification<ShortTrips.Cid, AnyObject>(name: "EntryCidRead")
    static let payment = Notification<ShortTrips.Cid, AnyObject>(name: "PaymentCidRead")
    static let unexpected = Notification<(expected: GtmsLocation, found: GtmsLocation), AnyObject>(name: "UnexpectedCid")
  }
  
  struct Driver {
    static let vehicleAssociated = Notification<(driver: ShortTrips.Driver, vehicle: Vehicle), AnyObject>(name: "DriverAndVehicleAssociated")
  }
  
  struct Geofence {
    static let exitingTerminals = Notification<Any?, AnyObject>(name: "ExitingTerminals")
    static let foundInside = Notification<[ShortTrips.Geofence], AnyObject>(name: "FoundInsideGeofences")
    static let insideSfo = Notification<Any?, AnyObject>(name: "InsideSfo")
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
    static let created = Notification<(ping: ShortTrips.Ping, geofenceStatus: FoundGeofenceStatus), AnyObject>(name: "CreatedPing")
    static let successful = Notification<ShortTrips.Ping, AnyObject>(name: "SuccessfulPing")
    static let unsuccessful = Notification<ShortTrips.Ping, AnyObject>(name: "unsuccessfulPing")
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
    static let optionalEntryStepFailed = Notification<Any?, AnyObject>(name: "optionalEntryStepFailed")
    static let reEntryAviFailed = Notification<Any?, AnyObject>(name: "reEntryAviFailed")
    static let started = Notification<Int, AnyObject>(name: "TripStarted")
    static let timeExpired = Notification<Any?, AnyObject>(name: "TripTimeExpired")
    static let validated = Notification<Any?, AnyObject>(name: "TripValidated")
    static let warning = Notification<TripWarning, AnyObject>(name: "TripWarning")
  }
}
