//
//  AssociatingDriverAndVehicle.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

struct AssociatingDriverAndVehicle {
  let stateName = "associatingDriverAndVehicle"
  static let sharedInstance = AssociatingDriverAndVehicle()

  private var state: TKState

  private init() {
    state = TKState(name: stateName)
  }

  func getState() -> TKState {
    return state
  }
}
