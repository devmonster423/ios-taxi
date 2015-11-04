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
      
      if let driver = DriverManager.sharedInstance.getCurrentDriver() {
        ApiClient.start(driver.driverId) { tripId in
          if let tripId = tripId {
            TripManager.sharedInstance.setTripId(tripId)
            TripStarted.sharedInstance.fire()
            
          }
//          else {
//            Failure.sharedInstance.fire()
//          }
        }
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
