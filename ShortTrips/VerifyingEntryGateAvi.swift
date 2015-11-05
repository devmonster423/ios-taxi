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
    
    private var poller: Poller?
    private var state: TKState
    
    private init() {
        state = TKState(name: stateName)
        
        state.setDidEnterStateBlock { _, _ in

          postNotification(SfoNotification.State.waitForEntryGateAvi, value: nil)
            
          self.poller = Poller.init(timeout: 60, action: { _ in
              if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
                  ApiClient.requestAntenna(vehicle.transponderId) { antenna in
                    if let antenna = antenna where antenna.device() == .TaxiEntry {
                      EntryGateAVIReadConfirmed.sharedInstance.fire(antenna)
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
