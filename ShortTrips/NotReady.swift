//
//  NotReady.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct NotReady {
  let stateName = "notReady"
  static let sharedInstance = NotReady()
  
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      TripManager.sharedInstance.reset(false)
      postNotification(SfoNotification.State.update, value: self.getState())
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
