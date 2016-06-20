//
//  WaitingInHoldingLot.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct WaitingInHoldingLot {
  let stateName = "waitingInHoldingLot"
  static let sharedInstance = WaitingInHoldingLot()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, transition  in
      postNotification(SfoNotification.State.update, value: self.getState())
      
      let intervalSec: Double = TripValidated.sharedInstance.getEvents().contains(transition.event)
        ? 60
        : 60 * 10
      
      let interval = dispatch_time(DISPATCH_TIME_NOW, Int64(intervalSec * Double(NSEC_PER_SEC)))
      
      dispatch_after(interval, dispatch_get_main_queue()) {
        InsideTaxiLoopExit.sharedInstance.fire()
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
