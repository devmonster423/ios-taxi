//
//  GpsIsOff.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/22/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct GpsIsOff {
  let stateName = "GpsIsOff"
  static let sharedInstance = GpsIsOff()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      TripManager.sharedInstance.reset(false)
      postNotification(SfoNotification.State.update, value: self.getState())
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
