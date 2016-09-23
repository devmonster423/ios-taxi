//
//  InProgress.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class InProgress {
  let stateName = "inProgress"
  static let sharedInstance = InProgress()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      NotificationCenter.default.post(name: .stateUpdate, object: nil, userInfo: [InfoKey.state: self.getState()])
    }
  }
  
  func getState() -> TKState {
    return state
  }
}

