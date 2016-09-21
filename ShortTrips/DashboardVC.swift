//
//  DashboardVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import JSQNotificationObserverKit
import MBProgressHUD

class DashboardVC: UIViewController {
  
  fileprivate var errorShown = false
  fileprivate var reachabilityObserver: ReachabilityObserver?
  
  override func loadView() {
    let dashboardView = DashboardView(frame: UIScreen.main.bounds)
    dashboardView.setReachabilityNoticeHidden(ReachabilityManager.sharedInstance.isReachable())
//#if DEBUG
//    let secretSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(DashboardVC.openDebugMode))
//    secretSwipeRecognizer.numberOfTouchesRequired = 2
//    secretSwipeRecognizer.direction = .Down
//    dashboardView.addGestureRecognizer(secretSwipeRecognizer)
//#endif
    view = dashboardView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = ""
    configureNavBar(title: NSLocalizedString("Holding Lot", comment: "").uppercased())
    addSettingsButton()
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(stopTimer),
      name: NSNotification.Name.UIApplicationDidEnterBackground,
      object: nil)
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(startTimer),
      name: NSNotification.Name.UIApplicationWillEnterForeground,
      object: nil)

    reachabilityObserver = NotificationObserver(notification: SfoNotification.Reachability.reachabilityChanged) { reachable, _ in
      self.dashboardView().setReachabilityNoticeHidden(reachable)
    }
  }
  
  func startTimer() {
    dashboardView().startTimerView(60, callback: requestLotStatus)
  }
  
  func stopTimer() {
    dashboardView().stopTimerView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopTimer()
  }
    
  func dashboardView() -> DashboardView {
    return self.view as! DashboardView
  }
    
  func requestLotStatus() {
    let hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud.labelText = NSLocalizedString("Requesting Lot Status", comment: "")
    
    ApiClient.requestQueueLength { length in
      
      hud.hide(true)
      
      if let length = length {
        self.dashboardView().updateSpots(length.longQueueLength)
        
      } else if !self.errorShown
        && self.tabBarController?.selectedIndex == MainTabs.lot.rawValue
        && self.navigationController?.visibleViewController == self {
          
          UiHelpers.displayErrorMessage(self, message: NSLocalizedString("An error occurred while fetching parking-lot data.", comment: ""))
          self.errorShown = true
      }
    }
  }
  
  func openDebugMode() {
    navigationController?.pushViewController(DebugVC(), animated: true)
  }
}
