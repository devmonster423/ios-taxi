//
//  AssociatingDriverAndVehicle.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct AssociatingDriverAndVehicleAtEntry {
  let stateName = "associatingDriverAndVehicleAtEntry"
  static let sharedInstance = AssociatingDriverAndVehicleAtEntry()

  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)

    state.setDidEnterStateBlock { _, _ in

      postNotification(SfoNotification.State.associatingDriverAndVehicleAtEntry, value: nil)

      self.poller = Poller.init(action: {
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.getVehicle(driver.cardId) { vehicle in

            if let vehicle = vehicle {
              DriverManager.sharedInstance.setCurrentVehicle(vehicle)
            }
          }
        }
      }, failure: {
        if let _ = TripManager.sharedInstance.getTripId() {
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
