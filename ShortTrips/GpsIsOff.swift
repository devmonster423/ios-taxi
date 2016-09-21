//
//  GpsIsOff.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/22/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct GpsIsOff {
  let stateName = "GpsIsOff"
  static let sharedInstance = GpsIsOff()
  
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
