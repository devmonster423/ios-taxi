//
//  VerifyingTaxiLoopAVI.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct VerifyingTaxiLoopAvi {
  let stateName = "verifyingTaxiLoopAvi"
  static let sharedInstance = VerifyingTaxiLoopAvi()
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
    
      postNotification(SfoNotification.State.waitForTaxiLoopAvi, value: nil)
      
      self.poller = Poller.init(timeout: 60, action: { _ in
        if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in
            
            if let antenna = antenna where antenna.device() == .TaxiStagingExit {
              LatestAviReadAtTaxiLoop.sharedInstance.fire(antenna)
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