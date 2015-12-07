//
//  InsideTaxiLoopExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct InsideTaxiLoopExit {
  let eventNames = ["insideTaxiLoopExit"]
  static let sharedInstance = InsideTaxiLoopExit()
  
  private var events: [TKEvent]
  
  private init() {
    
    let insideTaxiLoopExitEvent = TKEvent(name: eventNames[0],
      transitioningFromStates: [WaitingInHoldingLot.sharedInstance.getState(), NotReady.sharedInstance.getState(), WaitingForEntryCid.sharedInstance.getState(), AssociatingDriverAndVehicleAtEntry.sharedInstance.getState(), VerifyingEntryGateAvi.sharedInstance.getState()],
      toState: WaitingForPaymentCid.sharedInstance.getState())
    
    insideTaxiLoopExitEvent.setShouldFireEventBlock { _, transition -> Bool in
      
      if transition.sourceState == WaitingForEntryCid.sharedInstance.getState()
        || transition.sourceState == AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()
        || transition.sourceState == VerifyingEntryGateAvi.sharedInstance.getState() {
        
          return TripManager.sharedInstance.getTripId() == nil
            && LocationManager.locationActiveAndAuthorized()
      } else {
        return LocationManager.locationActiveAndAuthorized()
      }
    }
    
    events = [insideTaxiLoopExitEvent]
  }
}

extension InsideTaxiLoopExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
