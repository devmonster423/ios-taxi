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

struct VerifyingEntryGateAVI {
    let stateName = "verifyingEntryGateAVI"
    static let sharedInstance = VerifyingEntryGateAVI()
    
    private var poller: Poller?
    private var state: TKState
    
    private init() {
        state = TKState(name: stateName)
        
        state.setDidEnterStateBlock { _, _ in
            
            self.poller = Poller.init(timeout: 60, action: { _ in
                if let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {
                    ApiClient.requestAntenna(vehicle.transponderId) { cid in
                        
                        // TODO: actually verify if the antenna request succedeed
                        //        if let cid = cid where
                        //        cid.cidLocation == "entry" {
                        
                        EntryGateAVIReadConfirmed.sharedInstance.fire()
                        postNotification(SfoNotification.Avi.entryGate, value: cid)
                      
                        //  }
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