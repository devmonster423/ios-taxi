//
//  TimerDebugger.swift
//  ShortTrips
//
//  Created by Pierre Exygy on 11/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
    
  func fakeTimeExpired() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
      TimeExpired.sharedInstance.fire()
    }
  }
}
