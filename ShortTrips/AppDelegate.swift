//
//  AppDelegate.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

import Crashlytics
import Fabric
import Firebase
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  let stateManager = StateManager.sharedInstance // needed, to start the state machine
  var appCheckDelegate: AppChecker?
  var window: UIWindow?
  var appActiveFromPush = false

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    if launchOptions != nil,
    let _ = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [NSObject : AnyObject]? {
      appActiveFromPush = true
    }

    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    window = UIWindow(frame: UIScreen.main.bounds)
    let loginVC = LoginVC(startup: true)
    appCheckDelegate = loginVC
    window?.rootViewController = loginVC
    window?.makeKeyAndVisible()
    Fabric.with([Crashlytics.self()])
    FIRApp.configure()
    registerForPushNotifications(application)
    IQKeyboardManager.sharedManager().enable = true
    UIApplication.shared.isIdleTimerDisabled = true
    Speaker.sharedInstance.enableBackgroundAudio()
    return true
  }
  
  func registerForPushNotifications(_ application: UIApplication) {
    if #available(iOS 10.0, *) {
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(options: authOptions) {_, _ in }
      
    } else {
      let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }

    // dev only
    NotificationCenter.default.addObserver(forName: .firInstanceIDTokenRefresh, object: nil, queue: nil) { _ in
      if let refreshedToken = FIRInstanceID.instanceID().token() {
        print("InstanceID token: \(refreshedToken)")
        FIRMessaging.messaging().subscribe(toTopic: "/topics/cone")
        
        // only DEBUG!
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
//          FIRMessaging.messaging().subscribe(toTopic: "/topics/debug")
//        }
      }
    }
    
    application.registerForRemoteNotifications()
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    appCheckDelegate?.appDidBecomeActive()
  }

  func applicationWillTerminate(_ application: UIApplication) {
    PendingAppQuit.set(TripManager.sharedInstance.getTripId())
    AppQuit.sharedInstance.fire()
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    if let aps = userInfo["aps"] as? [String: Any], let message = aps["alert"] {
      NotificationCenter.default.post(
        name: .pushReceived,
        object: nil,
        userInfo: [InfoKey.pushText: message, InfoKey.appActive: application.applicationState == .active]
      )
    }
  }
}
