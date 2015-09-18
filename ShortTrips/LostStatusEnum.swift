//
//  LostStatusEnum.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

enum LotStatusEnum: String {
  case Yes = "yes"
  case No = "no"
  case Maybe = "maybe"
  
  static func random() -> LotStatusEnum {
    switch arc4random_uniform(3) {
    case 0:
      return .Yes
    case 1:
      return .Maybe
    default:
      return .No
    }
  }
}
