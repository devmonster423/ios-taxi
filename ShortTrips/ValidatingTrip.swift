//
//  Validating.swift
//  ShortTrips
//
//  Created by Joshua Adams on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class ValidatingTrip {
  let stateName = "validatingTrip"
  static let sharedInstance = ValidatingTrip()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      NotificationCenter.default.post(name: .stateUpdate, object: nil, userInfo: [InfoKey.state: self.getState()])
      
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

