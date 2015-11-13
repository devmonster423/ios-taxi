//
//  Validating.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct ValidatingTrip {
  let stateName = "validatingTrip"
  static let sharedInstance = ValidatingTrip()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.validatingTrip, value: nil)
      
      if let tripId = TripManager.sharedInstance.getTripId() {
        
        DriverManager.sharedInstance.getCurrentVehicle { vehicle in
          
          if let medallion = vehicle?.medallion {
            ApiClient.end(tripId, medallion: medallion) { validation in
              
              if let validation = validation {
                if validation.valid! {
                  TripValidated.sharedInstance.fire()
                } else {
                  TripInvalidated.sharedInstance.fire(validation.validationSteps)
                }
              } else {
                TripInvalidated.sharedInstance.fire()
              }
            }
          }
        }
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}

