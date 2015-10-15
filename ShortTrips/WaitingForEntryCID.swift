//
//  PollingForEntryCID.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct WaitingForEntryCID {
  let stateName = "waitingForEntryCID"
  static let sharedInstance = WaitingForEntryCID()

  private var state: TKState

  private init() {
    state = TKState(name: stateName)
  }

  func getState() -> TKState {
    return state
  }
}
