//
//  VerifyingExitAVI.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/29/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct VerifyingExitAvi {
  let stateName = "verifyingExitAvi"
  static let sharedInstance = VerifyingExitAvi()
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      self.poller = Poller.init(timeout: 60, action: { _ in
        if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in
            
            if let antenna = antenna where antenna.aviLocation == .Exit {
              LatestAviReadAtTaxiLoop.sharedInstance.fire()
              TripManager.sharedInstance.setStartTime(antenna.aviDate)
            } else {
              ExitAviReadFailed.sharedInstance.fire()
              StateManager.sharedInstance.addWarning(.ExitAviFailed)
            }
          }
        }
      })
    }
    
    state.setDidExitStateBlock { _, _ in
      self.poller?.stop()
    }
  }
  
  func getState() -> TKState {
    return state
  }
}
