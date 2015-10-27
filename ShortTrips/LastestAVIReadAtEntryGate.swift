//
//  LastestAVIReadAtEntryGate.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct LastestAVIReadAtEntryGate: Event {
    let eventName = "lastestAVIReadAtEntryGate"
    static let sharedInstance = LastestAVIReadAtEntryGate()
    
    private var event: TKEvent
    
    private init() {
        event = TKEvent(name: eventName,
            transitioningFromStates: [AssociatingDriverAndVehicle.sharedInstance.getState()],
            toState: AssociatingDriverAndVehicle.sharedInstance.getState())
    }
    
    func getEvent() -> TKEvent {
        return event
    }
}
