//
//  SfoObservers.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import JSQNotificationObserverKit
import TransitionKit

struct SfoObservers {
  // Avi
  var entryGateAvi: NotificationObserver<Antenna, AnyObject>?
  var exitAviRead: NotificationObserver<Antenna, AnyObject>?
  var inboundAviRead: NotificationObserver<Antenna, AnyObject>?
  var taxiLoopAviRead: NotificationObserver<Antenna, AnyObject>?
  var unexpectedAviRead: NotificationObserver<(expected: GtmsLocation, found: GtmsLocation), AnyObject>?
  
  // Cid
  var entryCidRead: NotificationObserver<Cid, AnyObject>?
  var paymentCidRead: NotificationObserver<Cid, AnyObject>?
  var unexpectedCidRead: NotificationObserver<(expected: GtmsLocation, found: GtmsLocation), AnyObject>?
  
  // Driver
  var driverAndVehicleAssociated: NotificationObserver<(driver: Driver, vehicle: Vehicle), AnyObject>?
  
  // Geofence
  var foundInsideGeofencesObserver: NotificationObserver<[Geofence], AnyObject>?
  var notInTerminalExitObserver: NotificationObserver<Any?, AnyObject>?
  var outsideShortTripObserver: NotificationObserver<Any?, AnyObject>?
  
  // Location
  var locationManagerStartedObserver: NotificationObserver<Any?, AnyObject>?
  var locationObserver: NotificationObserver<CLLocation, AnyObject>?
  var locationStatusObserver: NotificationObserver<CLAuthorizationStatus, AnyObject>?
  
  // Ping
  var attemptingPingObserver: NotificationObserver<Ping, AnyObject>?
  var invalidPingObserver: NotificationObserver<Ping, AnyObject>?
  var successfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var unsuccessfulPingObserver: NotificationObserver<Ping, AnyObject>?
  var validPingObserver: NotificationObserver<Ping, AnyObject>?
  
  // Request
  var responseObserver: NotificationObserver<NSHTTPURLResponse, AnyObject>?
  
  // State
  var stateUpdateObserver: NotificationObserver<TKState, AnyObject>?
  
  // Trip
  var invalidatedObserver: NotificationObserver<[ValidationStepWrapper]?, AnyObject>?
  var reEntryAviFailedObserver: NotificationObserver<Any?, AnyObject>?
  var timeExpiredObserver: NotificationObserver<Any?, AnyObject>?
  var tripStartedObserver: NotificationObserver<Int, AnyObject>?
  var validatedObserver: NotificationObserver<Any?, AnyObject>?
  var warningObserver: NotificationObserver<TripWarning, AnyObject>?
}