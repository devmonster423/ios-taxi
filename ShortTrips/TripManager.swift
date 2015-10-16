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
    NotReady.sharedInstance.getState(),
    WaitingForEntryCID.sharedInstance.getState(),
    AssociatingDriverAndVehicle.sharedInstance.getState(),
    Ready.sharedInstance.getState(),
    InProgress.sharedInstance.getState(),
    Validating.sharedInstance.getState(),
    Valid.sharedInstance.getState()
  ]
  
  private init() {
  
    machine = TKStateMachine()
    
    machine.addStates(TripManager.allStates)
    
    machine.initialState = NotReady.sharedInstance.getState()
    
    machine.addEvents([
      DriverDispatched.sharedInstance.getEvent(),
      DriverExitsSfo.sharedInstance.getEvent(),
      DriverProceedsToTaxiLoop.sharedInstance.getEvent(),
      DriverReturnsToSfo.sharedInstance.getEvent(),
      EnteredSFOGeofence.sharedInstance.getEvent(),
      Failure.sharedInstance.getEvent(),
      LatestCidIsEntryCid.sharedInstance.getEvent(),
      TripValidated.sharedInstance.getEvent()
      ])
    
    machine.activate()

    // start location manager
    LocationManager.sharedInstance.start()
    PingManager.sharedInstance.start()
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
