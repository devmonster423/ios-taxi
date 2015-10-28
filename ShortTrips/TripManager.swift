//
//  TripManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TripManager {
  
  static let sharedInstance = TripManager()
  
  private var machine: TKStateMachine
  
  static let allStates = [
    AssociatingDriverAndVehicle.sharedInstance.getState(),
    InProgress.sharedInstance.getState(),
    NotReady.sharedInstance.getState(),
    Ready.sharedInstance.getState(),
    Valid.sharedInstance.getState(),
    Validating.sharedInstance.getState(),
    VerifyingEntryGateAVI.sharedInstance.getState(),
    WaitingForEntryCID.sharedInstance.getState(),
    WaitingInHoldingLot.sharedInstance.getState()
  ]

  static let allEvents = [
    DriverAndVehicleAssociated.sharedInstance.getEvent(),
    DriverDispatched.sharedInstance.getEvent(),
    DriverExitsSfo.sharedInstance.getEvent(),
    DriverProceedsToTaxiLoop.sharedInstance.getEvent(),
    DriverReturnsToSfo.sharedInstance.getEvent(),
    EnteredSFOGeofence.sharedInstance.getEvent(),
    EntryGateAVIReadConfirmed.sharedInstance.getEvent(),
    Failure.sharedInstance.getEvent(),
    LatestCidIsEntryCid.sharedInstance.getEvent(),
    TripValidated.sharedInstance.getEvent()
  ]
  
  private init() {
  
    machine = TKStateMachine()
    
    machine.addStates(TripManager.allStates)
    
    machine.initialState = NotReady.sharedInstance.getState()
    
    machine.addEvents(TripManager.allEvents)
    
    machine.activate()

    // start location manager and geofence manager
    LocationManager.sharedInstance.start()
    GeofenceManager.sharedInstance.start()
  }
  
  func getMachine() -> TKStateMachine {
    return machine
  }
  
  func getTripId() -> Int? {
    // TODO:
    return 1
  }
}
