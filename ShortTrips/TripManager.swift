//
//  TripManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class TripManager {
  
  static let sharedInstance = TripManager()
  
  private var machine: TKStateMachine
  private var tripId: Int?
  
  static let allStates = [
    AssociatingDriverAndVehicle.sharedInstance.getState(),
    InProgress.sharedInstance.getState(),
    NotReady.sharedInstance.getState(),
    Ready.sharedInstance.getState(),
    Valid.sharedInstance.getState(),
    ValidatingTrip.sharedInstance.getState(),
    VerifyingEntryGateAVI.sharedInstance.getState(),
    VerifyingTaxiLoopAVI.sharedInstance.getState(),
    WaitingForEntryCID.sharedInstance.getState(),
    WaitingForPaymentCID.sharedInstance.getState(),
    WaitingForStartTrip.sharedInstance.getState(),
    WaitingInHoldingLot.sharedInstance.getState()
  ]
  
  static func allEvents() -> [TKEvent] {
    var events = DriverAndVehicleAssociated.sharedInstance.getEvents()
    events += OutsideSfo.sharedInstance.getEvents()
    events += DriverProceedsToTaxiLoop.sharedInstance.getEvents()
    events += EntryGateAVIReadConfirmed.sharedInstance.getEvents()
    events += Failure.sharedInstance.getEvents()
    events += InsideSfo.sharedInstance.getEvents()
    events += InsideTaxiLoopExit.sharedInstance.getEvents()
    events += LatestAviReadAtTaxiLoop.sharedInstance.getEvents()
    events += LatestCidIsEntryCid.sharedInstance.getEvents()
    events += LatestCidIsPaymentCid.sharedInstance.getEvents()
    events += TripStarted.sharedInstance.getEvents()
    events += TripValidated.sharedInstance.getEvents()
    return events
  }
  
  private init() {
  
    machine = TKStateMachine()
    
    machine.addStates(TripManager.allStates)
    
    machine.initialState = NotReady.sharedInstance.getState()
    
    machine.addEvents(TripManager.allEvents())
    
    machine.activate()

    // start location manager and geofence manager
    LocationManager.sharedInstance.start()
    GeofenceManager.sharedInstance.start()
  }
  
  func getMachine() -> TKStateMachine {
    return machine
  }
  
  func getTripId() -> Int? {
    return tripId
  }
  
  func setTripId(tripId: Int) {
    self.tripId = tripId
  }
}
