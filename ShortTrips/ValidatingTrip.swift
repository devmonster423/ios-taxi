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
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      if let tripId = TripManager.sharedInstance.getTripId(),
        driver = DriverManager.sharedInstance.getCurrentDriver(),
        sessionId = driver.sessionId,
        cardId = driver.cardId,
        medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion {

          ApiClient.end(tripId, tripBody: TripBody(sessionId: sessionId, medallion: medallion, smartCardId: cardId)) { validation in
            
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
    
    state.setDidExitStateBlock { _, _ in
      TripManager.sharedInstance.stop()
    }
  }
  
  func getState() -> TKState {
    return state
  }
}

