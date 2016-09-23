//
//  GpsIsOff.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/22/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class GpsIsOff {
  let stateName = "GpsIsOff"
  static let sharedInstance = GpsIsOff()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      TripManager.sharedInstance.reset(false)
      NotificationCenter.default.post(name: .stateUpdate, object: nil, userInfo: [InfoKey.state: self.getState()])
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
