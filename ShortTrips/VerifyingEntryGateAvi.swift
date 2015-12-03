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

struct VerifyingEntryGateAvi {
  let stateName = "verifyingEntryGateAvi"
  static let sharedInstance = VerifyingEntryGateAvi()
  private let expectedAvi: GtmsLocation = .TaxiEntry
  
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
              if device == .TaxiEntry {
                LatestAviReadAtEntry.sharedInstance.fire(antenna)
              } else {
                postNotification(SfoNotification.Avi.unexpected, value: (expected: self.expectedAvi, found: device))
              }
            }
          }
        }
      }, failure: {
        if let tripId = TripManager.sharedInstance.getTripId() {
          ApiClient.invalidate(tripId, validation: .Vehicle)
          ReEntryAviFailed.sharedInstance.fire()
        } else {
          OptionalEntryCheckFailed.sharedInstance.fire()
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
