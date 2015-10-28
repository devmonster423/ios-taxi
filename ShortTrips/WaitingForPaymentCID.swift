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

struct WaitingForPaymentCID {
  let stateName = "waitingForPaymentCID"
  static let sharedInstance = WaitingForPaymentCID()

  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)
    
    state.setDidEnterStateBlock { _, _ in
      
      self.poller = Poller.init(timeout: 60, action: { _ in
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.requestCidForSmartCard(driver.cardId) { cid in
            
            // TODO: actually verify if the smart card request succedeed
            //        if let cid = cid where
            //        cid.cidLocation == "entry" {
            
            LatestCidIsPaymentCid.sharedInstance.fire()
            postNotification(SfoNotification.Cid.payment, value: cid!)

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
