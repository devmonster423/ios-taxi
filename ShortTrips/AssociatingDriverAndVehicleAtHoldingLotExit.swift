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

  fileprivate var poller: Poller?
  fileprivate var state: TKState

  fileprivate init() {
    state = TKState(name: stateName)

    state.setDidEnter { _, _ in

      postNotification(SfoNotification.State.update, value: self.getState())

      self.poller = Poller.init() {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.getVehicle(driver.cardId) { vehicle in

            if let vehicle = vehicle , vehicle.isValid() {
              DriverManager.sharedInstance.setCurrentVehicle(vehicle)
              
            } else if !GeofenceManager.sharedInstance.stillInDomesticExitNotInHoldingLot() {
              NotInTaxiLoopOrInHoldingLotAfterFailedPaymentCheck.sharedInstance.fire()
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
