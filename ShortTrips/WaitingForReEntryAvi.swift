//
//  WaitingForReEntryAvi.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class WaitingForReEntryAvi {
  let stateName = "WaitingForReEntryAvi"
  static let sharedInstance = WaitingForReEntryAvi()
  private let expectedAvi: GtmsLocation = .TaxiEntry
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      let nc = NotificationCenter.default
      
      nc.post(name: .stateUpdate, object: nil, userInfo: [InfoKey.state: self.getState()])
      
      self.poller = Poller.init() {
        if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in
            
            if let antenna = antenna, let device = antenna.device() {
              if device == .TaxiEntry || device == .TaxiStatus {
                LatestAviAtReEntry.sharedInstance.fire(antenna)
              } else {
                nc.post(name: .aviUnexpected, object: nil, userInfo: [InfoKey.expectedGtmsLocation: self.expectedAvi, InfoKey.foundGtmsLocation: device])
                
                if !GeofenceManager.sharedInstance.stillInsideSfoBufferedExit() {
                  NotInsideSfoAfterFailedReEntryCheck.sharedInstance.fire()
                }
              }
            }
          }
        }
      }
    }
    
    state.setDidExitStateBlock { _, _ in
      self.poller?.stop()
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
