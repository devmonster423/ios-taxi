//
//  Validating.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct ValidatingTrip {
  let stateName = "validatingTrip"
  static let sharedInstance = ValidatingTrip()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      if let tripId = TripManager.sharedInstance.getTripId() {
        ApiClient.end(tripId) { valid in
          
          if let valid = valid where valid {
            TripValidated.sharedInstance.fire()
          } else {
            TripInvalidated.sharedInstance.fire()
          }
        }
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}

