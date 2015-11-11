//
//  PollingForEntryCID.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/14/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct WaitingForEntryCid {
  let stateName = "waitingForEntryCid"
  static let sharedInstance = WaitingForEntryCid()
  private let expectedCid: GtmsLocation = .TaxiEntry

  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)

    state.setDidEnterStateBlock { _, _ in
      postNotification(SfoNotification.State.waitForEntryCid, value: nil)

      self.poller = Poller.init(timeout: 60, action: { _ in
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.requestCid(driver.driverId) { cidDevice in
            
            if let cidDevice = cidDevice {
              if cidDevice == self.expectedCid {
                LatestCidIsEntryCid.sharedInstance.fire()
              } else {
                postNotification(SfoNotification.Cid.unexpected, value: (expected: self.expectedCid, found: cidDevice))
              }
            }
          }
        }
      }, failure: { _ in

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
