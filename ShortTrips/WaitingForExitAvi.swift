//
//  VerifyingExitAVI.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class WaitingForExitAvi {
  let stateName = "WaitingForExitAvi"
  static let sharedInstance = WaitingForExitAvi()
  
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      let nc = NotificationCenter.default
      nc.post(name: .stateUpdate, object: nil, userInfo: [InfoKey.state: self.getState()])
      
      if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
        DriverManager.sharedInstance.callWithValidSession {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in
            
            if let antenna = antenna, let device = antenna.device() {
              
              if device == .DomExit || device == .IntlArrivalExit {
                ExitAviCheckComplete.sharedInstance.fire(antenna)
              } else {
                ExitAviCheckComplete.sharedInstance.fire()
                nc.post(name: .aviUnexpected, object: nil, userInfo: [InfoKey.expectedGtmsLocation: .DomExit as GtmsLocation, InfoKey.foundGtmsLocation: device])
              }
            } else {
              ExitAviCheckComplete.sharedInstance.fire()
            }
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
