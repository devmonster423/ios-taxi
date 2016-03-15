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
              
              if (device == .DtaRecirculation || device == .TaxiMainLot)
                && antenna.aviDate.timeIntervalSinceNow > -(60*60) {
                  
                LatestAviAtTaxiLoop.sharedInstance.fire(antenna)
                  
              } else {
                postNotification(SfoNotification.Avi.unexpected, value: (expected: .DtaRecirculation, found: device))
                
                if !GeofenceManager.sharedInstance.stillInsideDomesticExit() {
                  NotInsideTaxiLoopExitAfterFailedPaymentCheck.sharedInstance.fire()
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