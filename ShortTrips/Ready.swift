//
//  Ready.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import TransitionKit
import JSQNotificationObserverKit

struct Ready {
  let stateName = "ready"
  static let sharedInstance = Ready()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.ready, value: nil)
      
      if let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId,
        let location = LocationManager.sharedInstance.getLastKnownLocation(),
        let tripId = TripManager.sharedInstance.getTripId() {
          
          ApiClient.postMobileStateChanges(MobileStateChange(longitude: location.coordinate.longitude,
            latitude: location.coordinate.latitude,
            tripId: tripId,
            tripState: .Short,
            mobileState: .Ready,
            sessionId: sessionId))
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
