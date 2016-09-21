//
//  Valid.swift
//  ShortTrips
//
//  Created by Pierre Hunault on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct WaitingForEntryAvi {
  let stateName = "WaitingForEntryAvi"
  static let sharedInstance = WaitingForEntryAvi()
  fileprivate let expectedAvi: GtmsLocation = .TaxiEntry
  
  fileprivate var poller: Poller?
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      postNotification(SfoNotification.State.update, value: self.getState())
      
      self.poller = Poller.init() {
        if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
          ApiClient.requestAntenna(vehicle.transponderId) { antenna in

            if let antenna = antenna, let device = antenna.device() {
              if device == .TaxiEntry {
                LatestAviAtEntry.sharedInstance.fire(antenna)
              } else {
                postNotification(SfoNotification.Avi.unexpected, value: (expected: self.expectedAvi, found: device))
                
                if !GeofenceManager.sharedInstance.stillInsideTaxiWaitZone() {
                  NotInsideTaxiWaitZoneAfterFailedEntryCheck.sharedInstance.fire()
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
