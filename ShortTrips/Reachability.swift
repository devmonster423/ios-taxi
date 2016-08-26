//
//  ReachabilityNotifiable.swift
//  ShortTrips
//
//  Created by Matt Luedke on 8/26/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import ReachabilitySwift

enum ReachabilityType {
  case Wifi
  case Cellular
  case None
  
  init(_ reachability: Reachability) {
    if reachability.isReachable() {
      if reachability.isReachableViaWiFi() {
        self = .Wifi
      } else {
        self = .Cellular
      }
    } else {
      self = .None
    }
  }
}

protocol ReachabilityNotifiable {
  func notify(reachability: ReachabilityType)
}
