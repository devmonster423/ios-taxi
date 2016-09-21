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
  
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, transition  in
      postNotification(SfoNotification.State.update, value: self.getState())
      
      let intervalSec: Double = TripManager.sharedInstance.getRightAfterValidShort()
        ? 60
        : 60 * 10
      
      let interval = DispatchTime.now() + Double(Int64(intervalSec * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
      
      DispatchQueue.main.asyncAfter(deadline: interval) {
        InsideTaxiLoopExit.sharedInstance.fire()
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
