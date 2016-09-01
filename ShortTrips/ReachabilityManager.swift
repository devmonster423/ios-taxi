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

struct ReachabilityManager {
  
  static let sharedInstance = ReachabilityManager()
  private var reachability: Reachability?
  
  private init() {
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      print("Unable to create Reachability")
      return
    }
    
    reachability!.whenReachable = { reachability in
      dispatch_async(dispatch_get_main_queue()) {
        postNotification(SfoNotification.Reachability.reachabilityChanged, value: true)
      }
    }
    
    reachability!.whenUnreachable = { reachability in
      dispatch_async(dispatch_get_main_queue()) {
        postNotification(SfoNotification.Reachability.reachabilityChanged, value: false)
      }
    }
    
    do {
      try reachability?.startNotifier()
    } catch{
      print("could not start reachability notifier")
    }
  }
  
  func isReachable() -> Bool {
    return reachability!.isReachable()
  }
}
