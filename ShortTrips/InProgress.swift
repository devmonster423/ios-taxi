//
//  InProgress.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct InProgress {
  let stateName = "inProgress"
  static let sharedInstance = InProgress()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      postNotification(SfoNotification.State.inProgress, value: nil)
      TripManager.sharedInstance.start()
    }
    
    state.setDidExitStateBlock { _, _ in
      TripManager.sharedInstance.stop()
    }
  }
  
  func getState() -> TKState {
    return state
  }
}

