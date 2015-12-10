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
  
  private var machine: TKStateMachine
  private var warnings = [TripWarning]()
  
  static let allStates = [
    AssociatingDriverAndVehicleAtEntry.sharedInstance.getState(),
    AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState(),
    AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState(),
    InProgress.sharedInstance.getState(),
    NotReady.sharedInstance.getState(),
    Ready.sharedInstance.getState(),
    ValidatingTrip.sharedInstance.getState(),
    VerifyingExitAvi.sharedInstance.getState(),
    WaitingForEntryAvi.sharedInstance.getState(),
    WaitingForEntryCid.sharedInstance.getState(),
    WaitingForPaymentCid.sharedInstance.getState(),
    WaitingForReEntryAvi.sharedInstance.getState(),
    WaitingForReEntryCid.sharedInstance.getState(),
    WaitingForStartTrip.sharedInstance.getState(),
    WaitingForTaxiLoopAvi.sharedInstance.getState(),
    WaitingInHoldingLot.sharedInstance.getState()
  ]
  
  static func allEvents() -> [TKEvent] {
    var events = AppQuit.sharedInstance.getEvents()
    events += DriverAndVehicleAssociated.sharedInstance.getEvents()
    events += ExitingTerminals.sharedInstance.getEvents()
    events += Failure.sharedInstance.getEvents()
    events += GpsDisabled.sharedInstance.getEvents()
    events += InsideSfo.sharedInstance.getEvents()
    events += InsideTaxiLoopExit.sharedInstance.getEvents()
    events += InsideTaxiWaitingZone.sharedInstance.getEvents()
    events += LatestAviAtEntry.sharedInstance.getEvents()
    events += LatestAviAtExit.sharedInstance.getEvents()
    events += LatestAviAtReEntry.sharedInstance.getEvents()
    events += LatestAviAtTaxiLoop.sharedInstance.getEvents()
    events += LatestCidIsEntryCid.sharedInstance.getEvents()
    events += LatestCidIsPaymentCid.sharedInstance.getEvents()
    events += LatestCidIsReEntryCid.sharedInstance.getEvents()
    events += LoggedOut.sharedInstance.getEvents()
    events += NotInTerminalExit.sharedInstance.getEvents()
    events += OutsideSfo.sharedInstance.getEvents()
    events += OutsideShortTripGeofence.sharedInstance.getEvents()
    events += TripInvalidated.sharedInstance.getEvents()
    events += TripStarted.sharedInstance.getEvents()
    events += TimeExpired.sharedInstance.getEvents()
    events += TripValidated.sharedInstance.getEvents()
    return events
  }
  
  private init() {
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
  
  func addWarning(warning: TripWarning) {
    warnings.append(warning)
  }
  
  func getWarnings() -> [TripWarning] {
    return warnings
  }
}
