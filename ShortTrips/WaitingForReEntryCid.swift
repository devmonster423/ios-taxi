//
//  WaitingForReEntryCid.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct WaitingForReEntryCid {
  let stateName = "waitingForReEntryCid"
  static let sharedInstance = WaitingForReEntryCid()
  private let expectedCid: GtmsLocation = .TaxiEntry
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      postNotification(SfoNotification.State.update, value: self.getState())
      
      self.poller = Poller.init() {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.requestCid(driver.driverId) { cid in
            
            if let cid = cid, device = cid.device() {
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
