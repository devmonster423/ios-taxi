//
//  WaitingForPaymentCID.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct WaitingForPaymentCid {
  let stateName = "waitingForPaymentCid"
  static let sharedInstance = WaitingForPaymentCid()
  private let expectedCid: GtmsLocation = .TaxiMainLot

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
                LatestCidIsPaymentCid.sharedInstance.fire(cid)
              } else {
                postNotification(SfoNotification.Cid.unexpected, value: (expected: self.expectedCid, found: device))
                
                if !GeofenceManager.sharedInstance.stillInsideTaxiLoopExit() {
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
