//
//  NotReady.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct NotReady {
  let stateName = "notReady"
  static let sharedInstance = NotReady()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      postNotification(SfoNotification.State.notReady, value: nil)
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
