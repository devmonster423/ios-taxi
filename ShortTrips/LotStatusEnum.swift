//
//  LostStatusEnum.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

enum LotStatusEnum: String {
  case Green = "green"
  case Yellow = "yellow"
  case Red = "red"
  
  static func random() -> LotStatusEnum {
    switch arc4random_uniform(3) {
    case 0:
      return .Green
    case 1:
      return .Yellow
    default:
      return .Red
    }
  }
}
