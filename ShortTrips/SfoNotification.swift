//
//  Notification.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import TransitionKit

enum InfoKey: String {
  case antenna = "antenna"
  case appActive = "appActive"
  case cid = "cid"
  case date = "date"
  case driver = "driver"
  case expectedGtmsLocation = "expectedGtmsLocation"
  case foundGtmsLocation = "foundGtmsLocation"
  case geofences = "geofences"
  case location = "location"
  case locationStatus = "locationStatus"
  case ping = "ping"
  case pushText = "pushText"
  case reachable = "reachable"
  case response = "response"
  case state = "state"
  case tripId = "tripId"
  case validationSteps = "validationSteps"
  case vehicle = "vehicle"
  case warning = "warning"
}

extension Notification.Name {
  
  // MARK: AVI
  static let aviRead = Notification.Name("AviRead")
  static let aviUnexpected = Notification.Name("UnexpectedAvi")
  
  // MARK: CID
  static let cidRead = Notification.Name("CidRead")
  static let cidUnexpected = Notification.Name("UnexpectedCid")
  
  // MARK: DRIVER
  static let driverVehicleAssociated = Notification.Name("DriverAndVehicleAssociated")
  static let logout = Notification.Name("Logout")
  
  // MARK: GEOFENCE
  static let foundInside = Notification.Name("FoundInsideGeofences")
  static let notInTerminalExit = Notification.Name("NotInTerminalExit")
  static let outsideBufferedExit = Notification.Name("OutsideBufferedExit")
  static let outsideShortTrip = Notification.Name("OutsideShortTrip")
  
  // MARK: LOCATION
  static let locManagerStarted = Notification.Name("LocationManagerStarted")
  static let locRead = Notification.Name("LocationRead")
  static let locStatusUpdated = Notification.Name("LocationStatusUpdated")
  
  // MARK: PING
  static let pingCreated = Notification.Name("CreatedPing")
  static let pingInvalid = Notification.Name("invalidPing")
  static let pingValid = Notification.Name("validPing")
  
  // MARK: PUSH
  static let pushReceived = Notification.Name("pushReceived")
  
  // MARK: REACHABILITY
  static let reachabilityChanged = Notification.Name("ReachabilityChanged")
  
  // MARK: RESPONSE
  static let response = Notification.Name("RequestResponse")
  
  // MARK: STATE
  static let stateUpdate = Notification.Name("StateUpdate")
  
  // MARK: TRIP
  static let timeExpired = Notification.Name("TripTimeExpired")
  static let tripInvalidated = Notification.Name("TripInvalidated")
  static let tripStarted = Notification.Name("TripStarted")
  static let tripValidated = Notification.Name("TripValidated")
  static let tripWarning = Notification.Name("TripWarning")
}
