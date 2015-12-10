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

struct WaitingForTaxiLoopAvi {
  let stateName = "WaitingForTaxiLoopAvi"
  static let sharedInstance = WaitingForTaxiLoopAvi()
  private let expectedAvi: GtmsLocation = .DtaRecirculation
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
    
      postNotification(SfoNotification.State.update, value: self.getState())
      
      self.poller = Poller.init(action: {
        if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in
            if let antenna = antenna, let device = antenna.device() {
              if device == self.expectedAvi {
                LatestAviAtTaxiLoop.sharedInstance.fire(antenna)
              } else {
                postNotification(SfoNotification.Avi.unexpected, value: (expected: self.expectedAvi, found: device))
              }
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