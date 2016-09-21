//
//  InProgress.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct InProgress {
  let stateName = "inProgress"
  static let sharedInstance = InProgress()
  
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      postNotification(SfoNotification.State.update, value: self.getState())
    }
  }
  
  func getState() -> TKState {
    return state
  }
}

