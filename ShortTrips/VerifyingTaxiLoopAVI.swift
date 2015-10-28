//
//  VerifyingTaxiLoopAVI.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct VerifyingTaxiLoopAVI {
  let stateName = "verifyingTaxiLoopAVI"
  static let sharedInstance = VerifyingTaxiLoopAVI()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
 }
  
  func getState() -> TKState {
    return state
  }
}