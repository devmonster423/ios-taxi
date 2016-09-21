//
//  WaitingForReEntryCid.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct WaitingForReEntryCid {
  let stateName = "waitingForReEntryCid"
  static let sharedInstance = WaitingForReEntryCid()
  fileprivate let expectedCid: GtmsLocation = .TaxiEntry
  
  fileprivate var poller: Poller?
  fileprivate var state: TKState
  
  fileprivate init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      postNotification(SfoNotification.State.update, value: self.getState())
      
      self.poller = Poller.init() {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.requestCid(driver.driverId) { cid in
            
            if let cid = cid, let device = cid.device() {
              if device == self.expectedCid {
                LatestCidIsReEntryCid.sharedInstance.fire(cid)
              } else {
                postNotification(SfoNotification.Cid.unexpected, value: (expected: self.expectedCid, found: device))
                
                if !GeofenceManager.sharedInstance.stillInsideSfoBufferedExit() {
                  NotInsideSfoAfterFailedReEntryCheck.sharedInstance.fire()
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
