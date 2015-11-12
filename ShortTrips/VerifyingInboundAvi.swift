//
//  VerifyingInboundAvi.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/30/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct VerifyingInboundAvi {
  let stateName = "verifyingInboundAvi"
  static let sharedInstance = VerifyingInboundAvi()
  private let expectedAvi: GtmsLocation = .Inbound
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      postNotification(SfoNotification.State.waitForInboundAvi, value: nil)
      
      self.poller = Poller.init(action: {
        if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in

            if let antenna = antenna, let device = antenna.device() {
              if device == self.expectedAvi {
                LatestAviReadInbound.sharedInstance.fire(antenna)
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
