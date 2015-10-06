//
//  TripManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct TripManager {
  
  static let sharedInstance = TripManager()
  private var machine: TKStateMachine
  
  private init() {
  
    machine = TKStateMachine()
    
    machine.addStates([
      NotReady.sharedInstance.getState(),
      Ready.sharedInstance.getState()
      ])
    
    machine.initialState = NotReady.sharedInstance.getState()
    
    machine.addEvents([
      DriverDispatched.sharedInstance.getEvent()
      ])
    
    machine.activate()
  }
  
  func getMachine() -> TKStateMachine {
    return machine
  }
}
