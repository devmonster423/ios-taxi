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
    TimeExpired.sharedInstance.fire()
  }
}
