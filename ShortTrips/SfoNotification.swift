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
    static let entryGate = Notification<Antenna, AnyObject>(name: "EntryGateAvi")
    static let exit = Notification<Antenna, AnyObject>(name: "ExitAvi")
    static let inbound = Notification<Antenna, AnyObject>(name: "InboundAvi")
    static let taxiLoop = Notification<Antenna, AnyObject>(name: "TaxiLoopAviRead")
  }

  struct Cid {
    static let entry = Notification<ShortTrips.Cid, AnyObject>(name: "EntryCidRead")
    static let payment = Notification<ShortTrips.Cid, AnyObject>(name: "PaymentCidRead")
  }
  
  struct Driver {
    static let vehicleAssociated = Notification<(driver: ShortTrips.Driver, vehicle: Vehicle), AnyObject>(name: "DriverAndVehicleAssociated")
  }
  
  struct Geofence {
    static let foundInside = Notification<[ShortTrips.Geofence], AnyObject>(name: "FoundInsideGeofences")
    static let insideSfo = Notification<Any?, AnyObject>(name: "InsideSfo")
    static let outsideSfo = Notification<Any?, AnyObject>(name: "OutsideSfo")
  }
  
  struct Location {
    static let managerStarted = Notification<Any?, AnyObject>(name: "LocationManagerStarted")
    static let read = Notification<CLLocation, AnyObject>(name: "LocationRead")
  }
  
  struct Ping {
    static let attempting = Notification<ShortTrips.Ping, AnyObject>(name: "AttemptingPing")
    static let successful = Notification<ShortTrips.Ping, AnyObject>(name: "SuccessfulPing")
    static let unsuccessful = Notification<ShortTrips.Ping, AnyObject>(name: "unsuccessfulPing")
    static let valid = Notification<ShortTrips.Ping, AnyObject>(name: "validPing")
    static let invalid = Notification<ShortTrips.Ping, AnyObject>(name: "invalidPing")
  }
  
  struct Request {
    static let response = Notification<NSHTTPURLResponse, AnyObject>(name: "RequestResponse")
  }
  
  struct State {
    static let associatingDriverAndVehicle = Notification<Any?, AnyObject>(name: "AssociatingDriverAndVehicle")
    static let wait = Notification<Any?, AnyObject>(name: "StartingToWait")
    static let ready = Notification<Any?, AnyObject>(name: "EnteredReadyState")
    static let inProgress = Notification<Any?, AnyObject>(name: "InProgress")
    static let waitForEntryCid = Notification<Any?, AnyObject>(name: "WaitForEntryCid")
    static let waitForEntryGateAvi = Notification<Any?, AnyObject>(name: "WaitForEntryGateAvi")
    static let waitForTaxiLoopAvi = Notification<Any?, AnyObject>(name: "WaitForTaxiLoopAvi")    
    static let waitForPaymentCid = Notification<Any?, AnyObject>(name: "WaitForPaymentCid")
    static let waitForExitAvi = Notification<Any?, AnyObject>(name: "WaitForExitAvi")
    static let notReady = Notification<Any?, AnyObject>(name: "NotReady")
  }
  
  struct Trip {
    static let started = Notification<Int, AnyObject>(name: "TripStarted")
    static let warning = Notification<TripWarning, AnyObject>(name: "TripWarning")
    static let validation = Notification<Bool, AnyObject>(name: "TripValidation")
    static let timeExpired = Notification<Any?, AnyObject>(name: "TripTimeExpired")
  }
}
