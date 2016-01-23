//
//  WaitingToStartTrip.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct StartingTrip {
  let stateName = "StartingTrip"
  static let sharedInstance = StartingTrip()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      if let driver = DriverManager.sharedInstance.getCurrentDriver(),
      sessionId = driver.sessionId,
      cardId = driver.cardId,
      vehicleId = DriverManager.sharedInstance.getCurrentVehicle()?.vehicleId {
      
        let medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion
        
        let tripBody = TripBody(sessionId: sessionId,
          medallion: medallion,
          vehicleId: vehicleId,
          smartCardId: cardId,
          deviceTimestamp: TripManager.sharedInstance.getStartTime() ?? NSDate()
        )
        
        ApiClient.start(tripBody) { tripId in
          
          if let tripId = tripId {
            TripManager.sharedInstance.start(tripId)
            
          } else {
            Failure.sharedInstance.fire()
          }
        }
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
