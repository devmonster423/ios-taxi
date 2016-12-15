//
//  WaitingForReEntryCid.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class WaitingForReEntryCid {
  let stateName = "waitingForReEntryCid"
  static let sharedInstance = WaitingForReEntryCid()
  private let expectedCid: GtmsLocation = .TaxiEntry
  
  private var poller: Poller?
  private var state: TKState
  
  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnter { _, _ in
      
      let nc = NotificationCenter.default
      
      nc.post(name: .stateUpdate, object: nil, userInfo: [InfoKey.state: self.getState()])
      
      self.poller = Poller.init() {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          DriverManager.sharedInstance.callWithValidSession {
            ApiClient.requestCid(driver.driverId) { cid in
              
              if let cid = cid, let device = cid.device() {
                if device == self.expectedCid {
                  LatestCidIsReEntryCid.sharedInstance.fire(cid)
                } else {
                  nc.post(name: .cidUnexpected, object: nil, userInfo: [InfoKey.expectedGtmsLocation: self.expectedCid, InfoKey.foundGtmsLocation: device])
                  
                  if !GeofenceManager.sharedInstance.stillInsideSfoBufferedExit() {
                    NotInsideSfoAfterFailedReEntryCheck.sharedInstance.fire()
                  }
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
