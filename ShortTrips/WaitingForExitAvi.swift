//
//  VerifyingExitAVI.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct WaitingForExitAvi {
  let stateName = "WaitingForExitAvi"
  static let sharedInstance = WaitingForExitAvi()
  
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
        ApiClient.requestAntenna(vehicle.transponderId) { antenna in
          
          if let antenna = antenna, let device = antenna.device() {
            
            if device == .DomExit || device == .IntlArrivalExit {
              ExitAviCheckComplete.sharedInstance.fire(antenna)
            } else {
              ExitAviCheckComplete.sharedInstance.fire()
              postNotification(SfoNotification.Avi.unexpected, value: (expected: .DomExit, found: device))
            }
          } else {
            ExitAviCheckComplete.sharedInstance.fire()
          }
        }
      } else {
        ExitAviCheckComplete.sharedInstance.fire()
      }
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
