//
//  SfoObservers.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import TransitionKit

struct SfoObservers {
  // Avi
  var entryGateAvi: NotificationObserver<Antenna, AnyObject>?
  var domExitAviRead: NotificationObserver<Antenna, AnyObject>?
  var domReEntryAvi: NotificationObserver<Antenna, AnyObject>?
  var intlArrivalExitAvi: NotificationObserver<Antenna, AnyObject>?
  var taxiLoopAviRead: NotificationObserver<Antenna, AnyObject>?
  var unexpectedAviRead: NotificationObserver<(expected: GtmsLocation, found: GtmsLocation), AnyObject>?
  
  // Cid
  var entryCidRead: NotificationObserver<Cid, AnyObject>?
  var paymentCidRead: NotificationObserver<Cid, AnyObject>?
  var unexpectedCidRead: NotificationObserver<(expected: GtmsLocation, found: GtmsLocation), AnyObject>?
  
  // Driver
  var driverAndVehicleAssociated: NotificationObserver<(driver: Driver, vehicle: Vehicle), AnyObject>?
  var logoutObserver: NotificationObserver<Any?, AnyObject>?
  
  // Geofence
  var foundInsideGeofencesObserver: NotificationObserver<[SfoGeofence], AnyObject>?
  var notInTerminalExitObserver: NotificationObserver<Any?, AnyObject>?
  var outsideShortTripObserver: NotificationObserver<Any?, AnyObject>?
  
  // Location
  var locationManagerStartedObserver: NotificationObserver<Any?, AnyObject>?
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  var locationStatusObserver: NotificationObserver<CLAuthorizationStatus, AnyObject>?
  
  // Ping
  var attemptingPingObserver: NotificationObserver<Ping, AnyObject>?
  var invalidPingObserver: NotificationObserver<Ping, AnyObject>?
  var validPingObserver: NotificationObserver<Ping, AnyObject>?
  
  // Request
  var responseObserver: NotificationObserver<NSHTTPURLResponse, AnyObject>?
  
  // State
  var stateUpdateObserver: NotificationObserver<TKState, AnyObject>?
  
  // Trip
  var invalidatedObserver: NotificationObserver<[ValidationStepWrapper]?, AnyObject>?
  var timeExpiredObserver: NotificationObserver<Any?, AnyObject>?
  var tripStartedObserver: NotificationObserver<Int, AnyObject>?
  var validatedObserver: NotificationObserver<NSDate, AnyObject>?
  var warningObserver: NotificationObserver<TripWarning, AnyObject>?
}
