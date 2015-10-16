//
//  PollingForEntryCID.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct WaitingForEntryCID {
  let stateName = "waitingForEntryCID"
  static let sharedInstance = WaitingForEntryCID()

  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)

    state.setDidEnterStateBlock { _, _ in
      
      self.poller = Poller.init(timeout: 60, action: { _ in
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.requestCidForSmartCard(driver.cardId) { cid in
            
            // TODO: actually verify if the CID is the entry CID
            //        if let cid = cid where
            //        cid.cidLocation == "entry" {
            
           // LatestCidIsEntryCid.sharedInstance.fire()
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
