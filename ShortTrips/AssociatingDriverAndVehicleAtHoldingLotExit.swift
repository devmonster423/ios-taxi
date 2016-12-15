//
//  AssociatingDriverAndVehicleAtHoldingLotExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class AssociatingDriverAndVehicleAtHoldingLotExit {
  let stateName = "associatingDriverAndVehicleAtHoldingLotExit"
  static let sharedInstance = AssociatingDriverAndVehicleAtHoldingLotExit()

  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)

    state.setDidEnter { _, _ in

      NotificationCenter.default.post(name: .stateUpdate, object: nil, userInfo: [InfoKey.state: self.getState()])

      self.poller = Poller.init() {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          DriverManager.sharedInstance.callWithValidSession {
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
    }

    state.setDidExitStateBlock { _, _ in
      self.poller?.stop()
    }
  }

  func getState() -> TKState {
    return state
  }
}
