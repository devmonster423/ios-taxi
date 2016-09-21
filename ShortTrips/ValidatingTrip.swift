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
  
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      guard let tripId = TripManager.sharedInstance.getTripId(),
      let driver = DriverManager.sharedInstance.getCurrentDriver(),
      let sessionId = driver.sessionId,
      let cardId = driver.cardId,
      let vehicleId = DriverManager.sharedInstance.getCurrentVehicle()?.vehicleId else {
      
        fatalError("invalid parameters for end trip")
      }

      let medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion
      
      let tripBody = TripBody(sessionId: sessionId,
        medallion: medallion,
        vehicleId: vehicleId,
        smartCardId: cardId,
        deviceTimestamp: Date()
      )
  
      ApiClient.end(tripId, tripBody: tripBody) { validation in
        
        if validation.valid! {
          TripValidated.sharedInstance.fire()
        } else {
          TripInvalidated.sharedInstance.fire(validation.validationSteps)
        }
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}

