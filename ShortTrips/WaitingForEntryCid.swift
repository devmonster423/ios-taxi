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
      postNotification(SfoNotification.State.update, value: self.getState())
      
      self.poller = Poller.init(timeout: 5*60, action: {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.requestCid(driver.driverId) { cid in
            
            if let cid = cid, device = cid.device() {
              if device == self.expectedCid {
                LatestCidIsEntryCid.sharedInstance.fire(cid)
              } else {
                postNotification(SfoNotification.Cid.unexpected, value: (expected: self.expectedCid, found: device))
              }
            }
          }
        }
      }, failure: {
        if let tripId = TripManager.sharedInstance.getTripId() {
          ApiClient.invalidate(tripId, validation: .DriverCardId)
          Failure.sharedInstance.fire()
        } else {
          OptionalEntryCheckFailed.sharedInstance.fire()
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
