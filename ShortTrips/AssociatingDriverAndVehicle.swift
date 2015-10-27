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

struct AssociatingDriverAndVehicle {
  let stateName = "associatingDriverAndVehicle"
  static let sharedInstance = AssociatingDriverAndVehicle()
  
  private var poller: Poller?
  private var state: TKState

  private init() {
    state = TKState(name: stateName)

    state.setDidEnterStateBlock { _, _ in
      
      self.poller = Poller.init(timeout: 60, action: { _ in
        if let driver = DriverManager.sharedInstance.getCurrentDriver() {
          ApiClient.getVehicle(driver.driverId) { vehicle in
            
            // TODO actually process vehicle - make sure association is right
            if let vehicle = vehicle {
            //  DriverManager.sharedInstance.setCurrentVehicle(vehicle)
              DriverAndVehicleAssociated.sharedInstance.fire()
              postNotification(SfoNotification.driverAndVehiculeAssociated, value: (driver: driver, vehicle: vehicle))

            }
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
