//
//  TallTabBarController.swift
//  ShortTrips
//
//  Created by Joshua Adams on 2/10/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit
import ReachabilitySwift

class TallTabBarController: UITabBarController {
  
  var reachability: Reachability?
  
  override func viewWillLayoutSubviews() {
    var tabFrame = self.tabBar.frame
    tabFrame.size.height = UiConstants.TabBarController.height
    tabFrame.origin.y = self.view.frame.size.height - UiConstants.TabBarController.height
    self.tabBar.frame = tabFrame
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      print("Unable to create Reachability")
      return
    }
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TallTabBarController.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
    do {
      try reachability?.startNotifier()
    } catch{
      print("could not start reachability notifier")
    }
  }
  
  func reachabilityChanged(note: NSNotification) {
    if let navVC = self.selectedViewController as? UINavigationController,
      let vc = navVC.visibleViewController as? ReachabilityNotifiable {
      vc.notify(ReachabilityType(note.object as! Reachability))
    }
  }
}
