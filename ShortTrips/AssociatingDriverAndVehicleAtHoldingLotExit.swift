//
//  AssociatingDriverAndVehicleAtHoldingLotExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct AssociatingDriverAndVehicleAtHoldingLotExit {
  let stateName = "associatingDriverAndVehicleAtHoldingLotExit"
  static let sharedInstance = AssociatingDriverAndVehicleAtHoldingLotExit()

  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)

    state.setDidEnterStateBlock { _, _ in

      postNotification(SfoNotification.State.update, value: self.getState())

      self.poller = Poller.init(failure: { TimedOutPaymentCheck.sharedInstance.fire() }) {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.getVehicle(driver.cardId) { vehicle in

            if let vehicle = vehicle {
              DriverManager.sharedInstance.setCurrentVehicle(vehicle)
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
