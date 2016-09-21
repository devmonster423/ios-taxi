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

typealias ReachabilityObserver = NotificationObserver<Bool, AnyObject>?

struct SfoNotification {
  struct Avi {
    static let domesticReEntry = Notification(name: Notification.Name(rawValue: "DomesticReEntryGateAvi"))
    static let entryGate = Notification(name: Notification.Name(rawValue: "EntryGateAvi"))
    static let domExit = Notification(name: Notification.Name(rawValue: "DomExitAvi"))
    static let intlArrivalExit = Notification(name: Notification.Name(rawValue: "IntlArrivalExitAvi"))
    static let taxiLoop = Notification(name: Notification.Name(rawValue: "TaxiLoopAviRead"))
    static let unexpected = Notification(name: Notification.Name(rawValue: "UnexpectedAvi"))
  }

  struct Cid {
    static let entry = Notification(name: Notification.Name(rawValue: "EntryCidRead"))
    static let payment = Notification(name: Notification.Name(rawValue: "PaymentCidRead"))
    static let unexpected = Notification(name: Notification.Name(rawValue: "UnexpectedCid"))
  }
  
  struct Driver {
    static let logout = Notification(name: Notification.Name(rawValue: "Logout"))
    static let vehicleAssociated = Notification(name: Notification.Name(rawValue: "DriverAndVehicleAssociated"))
  }
  
  struct Geofence {
    static let foundInside = Notification(name: Notification.Name(rawValue: "FoundInsideGeofences"))
    static let notInTerminalExit = Notification(name: Notification.Name(rawValue: "NotInTerminalExit"))
    static let outsideBufferedExit = Notification(name: Notification.Name(rawValue: "OutsideBufferedExit"))
    static let outsideShortTrip = Notification(name: Notification.Name(rawValue: "OutsideShortTrip"))
  }
  
  struct Location {
    static let managerStarted = Notification(name: Notification.Name(rawValue: "LocationManagerStarted"))
    static let read = Notification(name: Notification.Name(rawValue: "LocationRead"))
    static let statusUpdated = Notification(name: Notification.Name(rawValue: "LocationStatusUpdated"))
  }
  
  struct Ping {
    static let created = Notification(name: Notification.Name(rawValue: "CreatedPing"))
    static let valid = Notification(name: Notification.Name(rawValue: "validPing"))
    static let invalid = Notification(name: Notification.Name(rawValue: "invalidPing"))
  }
  
  struct Reachability {
    static let reachabilityChanged = Notification(name: Notification.Name(rawValue: "ReachabilityChanged"))
  }
  
  struct Request {
    static let response = Notification(name: Notification.Name(rawValue: "RequestResponse"))
  }
  
  struct State {
    static let update = Notification(name: Notification.Name(rawValue: "StateUpdate"))
  }
  
  struct Trip {
    static let invalidated = Notification(name: Notification.Name(rawValue: "TripInvalidated"))
    static let started = Notification(name: Notification.Name(rawValue: "TripStarted"))
    static let timeExpired = Notification(name: Notification.Name(rawValue: "TripTimeExpired"))
    static let validated = Notification(name: Notification.Name(rawValue: "TripValidated"))
    static let warning = Notification(name: Notification.Name(rawValue: "TripWarning"))
  }
}
