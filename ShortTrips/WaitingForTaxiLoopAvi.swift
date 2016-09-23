//
//  VerifyingTaxiLoopAVI.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class WaitingForTaxiLoopAvi {
  let stateName = "WaitingForTaxiLoopAvi"
  static let sharedInstance = WaitingForTaxiLoopAvi()
  
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
              
              if (device == .DtaRecirculation || device == .TaxiMainLot)
                && antenna.aviDate.timeIntervalSinceNow > -(15*60) {
                  
                LatestAviAtTaxiLoop.sharedInstance.fire(antenna)
                  
              } else {
                nc.post(name: .aviUnexpected, object: nil, userInfo: [InfoKey.expectedGtmsLocation: .DtaRecirculation, InfoKey.foundGtmsLocation: device])
                
                if !GeofenceManager.sharedInstance.stillInDomesticExitNotInHoldingLot() {
                  NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck.sharedInstance.fire()
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
