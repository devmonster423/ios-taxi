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
              
            } else if !GeofenceManager.sharedInstance.stillInsideTaxiWaitZone() {
              NotInsideTaxiWaitZoneAfterFailedEntryCheck.sharedInstance.fire()
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
