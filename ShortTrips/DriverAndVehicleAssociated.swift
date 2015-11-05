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
  let eventNames = ["driverAndVehicleAssociated"]
  static let sharedInstance = DriverAndVehicleAssociated()
    
  private var events: [TKEvent]
  
  private init() {
    events = [TKEvent(name: eventNames[0],
      transitioningFromStates: [AssociatingDriverAndVehicle.sharedInstance.getState()],
      toState: VerifyingEntryGateAvi.sharedInstance.getState())]
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
      postNotification(SfoNotification.Driver.vehicleAssociated, value: (driver: info.driver, vehicle: info.vehicle))
    }
  }
}