//
//  WaitingForPaymentCID.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 10/27/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class WaitingForPaymentCid {
  let stateName = "waitingForPaymentCid"
  static let sharedInstance = WaitingForPaymentCid()
  private let expectedCid: GtmsLocation = .TaxiMainLot

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
                  LatestCidIsPaymentCid.sharedInstance.fire(cid)
                } else {
                  nc.post(name: .cidUnexpected, object: nil, userInfo: [InfoKey.expectedGtmsLocation: self.expectedCid, InfoKey.foundGtmsLocation: device])
                  
                  if !GeofenceManager.sharedInstance.stillInDomesticExitNotInHoldingLot() {
                    NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck.sharedInstance.fire()
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
