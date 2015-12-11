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

struct WaitingForExitAvi {
  let stateName = "WaitingForExitAvi"
  static let sharedInstance = WaitingForExitAvi()
  private let expectedAvi: GtmsLocation = .Exit
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      self.poller = Poller.init() {
        if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in

            if let antenna = antenna, let device = antenna.device() {
              if device == self.expectedAvi {
                LatestAviAtExit.sharedInstance.fire(antenna)
                TripManager.sharedInstance.setStartTime(antenna.aviDate)
              } else {
                postNotification(SfoNotification.Avi.unexpected, value: (expected: self.expectedAvi, found: device))
              }
            }
          }
        } else {
          Failure.sharedInstance.fire()
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
