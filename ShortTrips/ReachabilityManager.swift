//
//  ReachabilityManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 8/26/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit
import ReachabilitySwift

class ReachabilityManager {
  
  static let sharedInstance = ReachabilityManager()
  private var reachability: Reachability?
  private var lastAnnouncedAsConnected = true
  private let waitTimeSec: Double = 15
  private var pendingNotification: NSUUID?
  
  private init() {
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      print("Unable to create Reachability")
      return
    }
    
    reachability!.whenReachable = { reachability in
      self.potentiallySpeak(true)
      dispatch_async(dispatch_get_main_queue()) {
        postNotification(SfoNotification.Reachability.reachabilityChanged, value: true)
      }
    }
    
    reachability!.whenUnreachable = { reachability in
      self.potentiallySpeak(false)
      dispatch_async(dispatch_get_main_queue()) {
        postNotification(SfoNotification.Reachability.reachabilityChanged, value: false)
      }
    }
    
    do {
      try reachability?.startNotifier()
      lastAnnouncedAsConnected = reachability!.isReachable()
    } catch {
      print("could not start reachability notifier")
    }
  }
  
  func isReachable() -> Bool {
    return reachability!.isReachable()
  }
  
  func potentiallySpeak(connected: Bool) {
    
    if lastAnnouncedAsConnected == connected {
      // cancel any pending notification
      pendingNotification = nil
      
    } else {
      // schedule notification in 15 seconds
      let notificationId = NSUUID()
      pendingNotification = notificationId
      let waitTime = dispatch_time(DISPATCH_TIME_NOW, Int64(waitTimeSec * Double(NSEC_PER_SEC)))
      dispatch_after(waitTime, dispatch_get_main_queue()) {
        if let notification = self.pendingNotification where notification.isEqual(notificationId) {
          Speaker.sharedInstance.speak(
            connected
              ? NSLocalizedString("Internet Connection Reestablished", comment: "")
              : NSLocalizedString("Internet Connection Lost", comment: "")
          )
          self.lastAnnouncedAsConnected = connected
        }
      }
    }
  }
}
