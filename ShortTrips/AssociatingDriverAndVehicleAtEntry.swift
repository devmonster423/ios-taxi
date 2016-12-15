//
//  AssociatingDriverAndVehicle.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class AssociatingDriverAndVehicleAtEntry {
  let stateName = "associatingDriverAndVehicleAtEntry"
  static let sharedInstance = AssociatingDriverAndVehicleAtEntry()

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
                
              } else if !GeofenceManager.sharedInstance.stillInsideTaxiWaitZone() {
                NotInsideTaxiWaitZoneAfterFailedEntryCheck.sharedInstance.fire()
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
