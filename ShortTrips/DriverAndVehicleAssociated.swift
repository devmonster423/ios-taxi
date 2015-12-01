//
//  DriverAndVehicleAssociated.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct DriverAndVehicleAssociated {
  let eventNames = ["driverAndVehicleAssociatedAtEntry",
    "driverAndVehicleAssociatedAtHoldingLotExit",
    "driverAndVehicleAssociatedAtReEntry"]
  static let sharedInstance = DriverAndVehicleAssociated()
    
  private var events: [TKEvent]
  
  private init() {
    
    let driverAndVehicleAssociatedAtEntry = TKEvent(name: eventNames[0],
      transitioningFromStates: [AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()],
      toState: VerifyingEntryGateAvi.sharedInstance.getState())
    
    driverAndVehicleAssociatedAtEntry.setShouldFireEventBlock { _, _ -> Bool in
      return TripManager.sharedInstance.getTripId() == nil
    }
    
    let driverAndVehicleAssociatedAtHoldingLotExit = TKEvent(name: eventNames[1],
      transitioningFromStates: [AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState()],
      toState: VerifyingTaxiLoopAvi.sharedInstance.getState())
    
    let driverAndVehicleAssociatedAtReEntry = TKEvent(name: eventNames[2],
      transitioningFromStates: [AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()],
      toState: ValidatingTrip.sharedInstance.getState())
    
    driverAndVehicleAssociatedAtReEntry.setShouldFireEventBlock { _, _ -> Bool in
      return TripManager.sharedInstance.getTripId() != nil
    }
    
    events = [
      driverAndVehicleAssociatedAtEntry,
      driverAndVehicleAssociatedAtHoldingLotExit,
      driverAndVehicleAssociatedAtReEntry
    ]
  }
}

extension DriverAndVehicleAssociated: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension DriverAndVehicleAssociated: Observable {
  func eventIsFiring(info: Any?) {
    if let info = info as? (driver: Driver, vehicle: Vehicle) {
      postNotification(SfoNotification.Driver.vehicleAssociated, value: info)
    }
  }
}
