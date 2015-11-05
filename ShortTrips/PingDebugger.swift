//
//  PingDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/2/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

protocol PingDebugger { }

extension PingDebugger where Self: DebugVC {
  
  func setupPingObservers() {
    attemptingPingObserver = NotificationObserver(notification: SfoNotification.Ping.attempting) { ping, _ in
      
      self.debugView().printDebugLine("attempting ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    }
    
    successfulPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.debugView().printDebugLine("successful ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    })
    
    unsuccessfulPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.debugView().printDebugLine("unsuccessful ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)", type: .Negative)
    })
    
    validPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.debugView().printDebugLine("valid ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
    })
    
    invalidPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.debugView().printDebugLine("invalid ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)", type: .Negative)
    })
  }
}
