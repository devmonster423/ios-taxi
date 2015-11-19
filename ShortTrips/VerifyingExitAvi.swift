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
  private let expectedAvi: GtmsLocation = .TerminalExit
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.waitForExitAvi, value: nil)
      
      self.poller = Poller.init(timeout: nil, action: {
        if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in

            if let antenna = antenna, let device = antenna.device() {
              if device == self.expectedAvi {
                LatestAviReadAtTaxiLoop.sharedInstance.fire(antenna)
                TripManager.sharedInstance.setStartTime(antenna.aviDate)
              } else {
                postNotification(SfoNotification.Avi.unexpected, value: (expected: self.expectedAvi, found: device))
              }
            }
          }
        } else {
          Failure.sharedInstance.fire()
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
