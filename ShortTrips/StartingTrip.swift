//
//  WaitingToStartTrip.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class StartingTrip {
  let stateName = "StartingTrip"
  static let sharedInstance = StartingTrip()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      NotificationCenter.default.post(name: .stateUpdate, object: nil, userInfo: [InfoKey.state: self.getState()])
      
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
