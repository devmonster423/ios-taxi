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

  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      self.poller = Poller.init(timeout: 60, action: { _ in
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.requestCidForSmartCard(driver.cardId) { cidDevice in
          
          if let cidDevice = cidDevice where cidDevice == .TaxiStagingExit {
            LatestCidIsEntryCid.sharedInstance.fire()
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
