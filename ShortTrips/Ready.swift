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
      
      if let location = LocationManager.sharedInstance.getLastKnownLocation() {
          ApiClient.updateMobileState(.Ready, mobileStateInfo: MobileStateInfo(longitude: location.coordinate.longitude,
            latitude: location.coordinate.latitude,
            tripId: nil))
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
