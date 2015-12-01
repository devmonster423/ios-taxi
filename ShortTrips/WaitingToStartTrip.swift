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

struct WaitingForStartTrip {
  let stateName = "waitingForStartTrip"
  static let sharedInstance = WaitingForStartTrip()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      if let driver = DriverManager.sharedInstance.getCurrentDriver(),
      sessionId = driver.sessionId,
      cardId = driver.cardId,
      medallion = DriverManager.sharedInstance.getCurrentVehicle()?.medallion  {
          
        ApiClient.start(TripBody(sessionId: sessionId, medallion: medallion, smartCardId: cardId)) { tripId in
          
          if let tripId = tripId {
            TripStarted.sharedInstance.fire(tripId)
            
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
