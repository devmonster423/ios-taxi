//
//  NotificationManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/14/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit

import Firebase
import UserNotifications

enum NotificationType: String {
  case cone = "cone"
  case debug = "debug"
  case localdev = "localdev"
  
  static let allValues: [NotificationType] = {
    var array = [cone]
    
    #if DEBUG
      array.append(debug)
    #endif
    
    #if LOCALDEV
      array.append(localdev)
    #endif
    
    return array
  }()
  
  static func fromInt(_ int: Int) -> NotificationType {
    return allValues[int]
  }
}

struct NotificationManager {
  
  static func setNotificationEnabled(_ notificationType: NotificationType, on: Bool) {
    UserDefaults.standard.set(on, forKey: notificationType.rawValue)
    refreshSubscription(notificationType)
  }
  
  static func getNotificationEnabled(_ notificationType: NotificationType) -> Bool {
    if let enabled = UserDefaults.standard.object(forKey: notificationType.rawValue) as? Bool {
      return enabled
    } else {
      setNotificationEnabled(notificationType, on: true)
      return true // default
    }
  }
  
  static func topicString(_ notificationType: NotificationType) -> String {
    return "/topics/" + notificationType.rawValue
  }
  
  static func refreshSubscription(_ notificationType: NotificationType) {
    if NotificationManager.getNotificationEnabled(notificationType) {
      FIRMessaging.messaging().subscribe(toTopic: topicString(notificationType))
    } else {
      FIRMessaging.messaging().unsubscribe(fromTopic: topicString(notificationType))
    }
  }
  
  static func registerForPushNotifications(_ application: UIApplication) {
    
    FIRApp.configure()
    
    if #available(iOS 10.0, *) {
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(options: authOptions) {_, _ in }
      
    } else {
      let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    
    NotificationCenter.default.addObserver(forName: .firInstanceIDTokenRefresh, object: nil, queue: nil) { _ in
      if let refreshedToken = FIRInstanceID.instanceID().token() {
        print("InstanceID token: \(refreshedToken)")
        
        for notificationType in NotificationType.allValues {
          refreshSubscription(notificationType)
        }
      }
    }
    
    application.registerForRemoteNotifications()
  }
}
