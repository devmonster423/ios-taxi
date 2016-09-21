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

struct Ready {
  let stateName = "ready"
  static let sharedInstance = Ready()
  
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      DriverManager.sharedInstance.callWithValidSession {
        
        guard let location = LocationManager.sharedInstance.getLastKnownLocation(),
          let sessionId = DriverManager.sharedInstance.getCurrentDriver()?.sessionId else {
            
            fatalError("can't update mobile state")
        }
        
        ApiClient.updateMobileState(.Ready, mobileStateInfo: MobileStateInfo(longitude: location.coordinate.longitude,
          latitude: location.coordinate.latitude,
          sessionId: sessionId))
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
