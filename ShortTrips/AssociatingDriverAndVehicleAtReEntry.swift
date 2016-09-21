//
//  AssociatingDriverAndVehicleAtReEntry.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

struct AssociatingDriverAndVehicleAtReEntry {
  let stateName = "associatingDriverAndVehicleAtReEntry"
  static let sharedInstance = AssociatingDriverAndVehicleAtReEntry()
  
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
              
            } else if !GeofenceManager.sharedInstance.stillInsideSfoBufferedExit() {
              NotInsideSfoAfterFailedReEntryCheck.sharedInstance.fire()
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
