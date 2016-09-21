//
//  StateManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class StateManager {
  
  static let sharedInstance = StateManager()
  
  fileprivate var machine: TKStateMachine
  fileprivate var warnings = [TripWarning]()
  
  static let allStates = [
    AssociatingDriverAndVehicleAtEntry.sharedInstance.getState(),
    AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState(),
    AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState(),
    GpsIsOff.sharedInstance.getState(),
    InProgress.sharedInstance.getState(),
    NotReady.sharedInstance.getState(),
    Ready.sharedInstance.getState(),
    StartingTrip.sharedInstance.getState(),
    ValidatingTrip.sharedInstance.getState(),
    WaitingForEntryAvi.sharedInstance.getState(),
    WaitingForEntryCid.sharedInstance.getState(),
    WaitingForExitAvi.sharedInstance.getState(),
    WaitingForPaymentCid.sharedInstance.getState(),
    WaitingForReEntryAvi.sharedInstance.getState(),
    WaitingForReEntryCid.sharedInstance.getState(),
    WaitingForTaxiLoopAvi.sharedInstance.getState(),
    WaitingInHoldingLot.sharedInstance.getState()
  ]
  
  static func allEvents() -> [TKEvent] {
    var events = AppQuit.sharedInstance.getEvents()
    events += DriverAndVehicleAssociated.sharedInstance.getEvents()
    events += ExitAviCheckComplete.sharedInstance.getEvents()
    events += Failure.sharedInstance.getEvents()
    events += GpsDisabled.sharedInstance.getEvents()
    events += GpsEnabled.sharedInstance.getEvents()
    events += InsideBufferedExit.sharedInstance.getEvents()
    events += InsideTaxiLoopExit.sharedInstance.getEvents()
    events += InsideTaxiWaitingZone.sharedInstance.getEvents()
    events += LatestAviAtEntry.sharedInstance.getEvents()
    events += LatestAviAtReEntry.sharedInstance.getEvents()
    events += LatestAviAtTaxiLoop.sharedInstance.getEvents()
    events += LatestCidIsEntryCid.sharedInstance.getEvents()
    events += LatestCidIsPaymentCid.sharedInstance.getEvents()
    events += LatestCidIsReEntryCid.sharedInstance.getEvents()
    events += LoggedOut.sharedInstance.getEvents()
    events += NotInsideSfoAfterFailedReEntryCheck.sharedInstance.getEvents()
    events += NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck.sharedInstance.getEvents()
    events += NotInsideTaxiWaitZoneAfterFailedEntryCheck.sharedInstance.getEvents()
    events += OutsideBufferedExit.sharedInstance.getEvents()
    events += OutsideShortTripGeofence.sharedInstance.getEvents()
    events += OutsideTaxiWaitZone.sharedInstance.getEvents()
    events += TripInvalidated.sharedInstance.getEvents()
    events += TimeExpired.sharedInstance.getEvents()
    events += TripStarted.sharedInstance.getEvents()
    events += TripValidated.sharedInstance.getEvents()
    return events
  }
  
  fileprivate init() {
    machine = TKStateMachine()
    machine.addStates(StateManager.allStates)
    machine.initialState = NotReady.sharedInstance.getState()
    machine.addEvents(StateManager.allEvents())
    machine.activate()
    LocationManager.sharedInstance.start()
    GeofenceManager.sharedInstance.start()
  }
  
  func getMachine() -> TKStateMachine {
    return machine
  }
  
  func addWarning(_ warning: TripWarning) {
    warnings.append(warning)
  }
  
  func getWarnings() -> [TripWarning] {
    return warnings
  }
}
