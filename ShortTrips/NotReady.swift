//
//  NotReady.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class NotReady {
  let stateName = "notReady"
  static let sharedInstance = NotReady()
  
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
