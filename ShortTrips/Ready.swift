//
//  Ready.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct Ready {
  let stateName = "ready"
  static let sharedInstance = Ready()
  
  private var state: TKState
  
  private init() {
    
    state = TKState(name: stateName)
    
    state.setWillEnterStateBlock { (state, transition) -> Void in
      // do something when about to enter state
    }
    state.setDidEnterStateBlock { (state, transition) -> Void in
      // do something when entered state
    }
    state.setWillExitStateBlock { (state, transition) -> Void in
      // do something when about to exit state
    }
    state.setDidExitStateBlock { (state, transition) -> Void in
      // do something when exited state
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
