//
//  WaitingToStartTrip.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct StartingTrip {
  let stateName = "StartingTrip"
  static let sharedInstance = StartingTrip()
  
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      DriverManager.sharedInstance.callWithValidSession {
        
        guard let driver = DriverManager.sharedInstance.getCurrentDriver(),
          let sessionId = driver.sessionId,
          let cardId = driver.cardId,
          let vehicleId = DriverManager.sharedInstance.getCurrentVehicle()?.vehicleId else {
          
            fatalError("invalid info when starting trip")
        }
          
        let medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion
        
        let tripBody = TripBody(sessionId: sessionId,
          medallion: medallion,
          vehicleId: vehicleId,
          smartCardId: cardId,
          deviceTimestamp: TripManager.sharedInstance.getStartTime() ?? Date()
        )
        
        ApiClient.start(tripBody) { tripId in
          TripManager.sharedInstance.start(tripId)
        }
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
