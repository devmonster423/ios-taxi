//
//  DriverAndVehicleAssociated.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverAndVehicleAssociated {
  let eventNames = ["driverAndVehicleAssociatedAtEntry",
    "driverAndVehicleAssociatedAtHoldingLotExit",
    "driverAndVehicleAssociatedAtReEntry"]
  static let sharedInstance = DriverAndVehicleAssociated()
    
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()],
        to: WaitingForEntryAvi
          .sharedInstance.getState()),
      
      TKEvent(name: eventNames[1],
        transitioningFromStates: [AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState()],
        to: WaitingForTaxiLoopAvi.sharedInstance.getState()),
      
      TKEvent(name: eventNames[2],
        transitioningFromStates: [AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState()],
        to: WaitingForReEntryAvi.sharedInstance.getState())
    ]
  }
}

extension DriverAndVehicleAssociated: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}

extension DriverAndVehicleAssociated: Observable {
  func eventIsFiring(_ info: Any?) {
    if let info = info as? (driver: Driver, vehicle: Vehicle) {
      postNotification(SfoNotification.Driver.vehicleAssociated, value: info)
    }
  }
}
