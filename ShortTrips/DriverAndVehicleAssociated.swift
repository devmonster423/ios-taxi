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