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
  fileprivate var reachability: Reachability?
  fileprivate var lastAnnouncedAsConnected = true
  fileprivate let waitTimeSec: Double = 15
  fileprivate var pendingNotification: UUID?
  
  fileprivate init() {
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
  
  func potentiallySpeak(_ connected: Bool) {
    
    if lastAnnouncedAsConnected == connected {
      // cancel any pending notification
      pendingNotification = nil
      
    } else {
      // schedule notification in 15 seconds
      let notificationId = UUID()
      pendingNotification = notificationId
      let waitTime = DispatchTime.now() + Double(Int64(waitTimeSec * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
      DispatchQueue.main.asyncAfter(deadline: waitTime) {
        if let notification = self.pendingNotification , (notification == notificationId) {
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
