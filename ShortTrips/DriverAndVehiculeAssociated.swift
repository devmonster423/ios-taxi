//
//  DriverAndVehiculeAssociated.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct DriverAndVehiculeAssociated: Event {
    let eventName = "driverAndVehiculeAssociated"
    static let sharedInstance = DriverAndVehiculeAssociated()
    
    private var event: TKEvent
    
    private init() {
      event = TKEvent(name: eventName,
        transitioningFromStates: [AssociatingDriverAndVehicle.sharedInstance.getState()],
        toState: VerifyingEntryGateAVI.sharedInstance.getState())
    }
    
    func getEvent() -> TKEvent {
        return event
    }

}