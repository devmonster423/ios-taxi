//
//  TripStartPending.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/21/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import TransitionKit
import JSQNotificationObserverKit

struct TripStartPending {
  let stateName = "TripStartPending"
  static let sharedInstance = TripStartPending()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      postNotification(SfoNotification.State.update, value: self.getState())
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
