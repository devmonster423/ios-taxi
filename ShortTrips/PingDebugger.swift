//
//  PingDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/2/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupPingObservers() {
    sfoObservers.validPingObserver = NotificationObserver(notification: SfoNotification.Ping.valid, handler: { ping, _ in
      self.debugView().printDebugLine("valid ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    })
    
    sfoObservers.invalidPingObserver = NotificationObserver(notification: SfoNotification.Ping.invalid, handler: { ping, _ in
      self.debugView().printDebugLine("invalid ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)", type: .Negative)
    })
  }
  
  func turnOffPings() {
    PingKiller.sharedInstance.turnOffPingsForAWhile()
    self.debugView().printDebugLine("pings will fail for 2 min", type: .negative)
  }
}
