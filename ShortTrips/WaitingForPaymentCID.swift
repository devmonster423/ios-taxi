//
//  WaitingForPaymentCID.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct WaitingForPaymentCID {
  let stateName = "waitingForPaymentCID"
  static let sharedInstance = WaitingForPaymentCID()

  private var state: TKState

  private init() {
    state = TKState(name: stateName)
  }
  
  func getState() -> TKState {
    return state
  }
}