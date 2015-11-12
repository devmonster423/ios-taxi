//
//  AssociatingDriverAndVehicleInbound.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct AssociatingDriverAndVehicleInbound {
  let stateName = "associatingDriverAndVehicleInbound"
  static let sharedInstance = AssociatingDriverAndVehicleInbound()

  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)

    state.setDidEnterStateBlock { _, _ in

      postNotification(SfoNotification.State.associatingDriverAndVehicleInbound, value: nil)

      if let driver = DriverManager.sharedInstance.getCurrentDriver(),
        let vehicle = DriverManager.sharedInstance.getCurrentVehicle() {

          let driverAndVehicle = (driver: driver, vehicle: vehicle)
          DriverAndVehicleAssociated.sharedInstance.fire(driverAndVehicle)

      } else {
        Failure.sharedInstance.fire()
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
