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
  }
  
  func getState() -> TKState {
    return state
  }
}
