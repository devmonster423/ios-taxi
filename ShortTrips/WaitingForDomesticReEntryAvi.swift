//
//  WaitingForDomesticReEntryAvi.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/8/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct WaitingForDomesticReEntryAvi {
  let stateName = "WaitingForDomesticReEntryAvi"
  static let sharedInstance = WaitingForDomesticReEntryAvi()
  private let expectedAvi: GtmsLocation = .DtEntrance
  
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
                LatestAviAtDomesticReEntry.sharedInstance.fire(antenna)
              } else {
                postNotification(SfoNotification.Avi.unexpected, value: (expected: self.expectedAvi, found: device))
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
