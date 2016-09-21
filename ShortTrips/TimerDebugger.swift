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
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
      TimeExpired.sharedInstance.fire()
    }
  }
}
