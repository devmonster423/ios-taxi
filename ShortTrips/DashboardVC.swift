//
//  DashboardVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import MBProgressHUD

class DashboardVC: UIViewController {
  
  var errorShown = false
  
  override func loadView() {
    let dashboardView = DashboardView(frame: UIScreen.mainScreen().bounds)
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
    configureNavBar(title: NSLocalizedString("Holding Lot", comment: "").uppercaseString)
    addSettingsButton()
    
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: #selector(stopTimer),
      name: UIApplicationDidEnterBackgroundNotification,
      object: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: #selector(startTimer),
      name: UIApplicationWillEnterForegroundNotification,
      object: nil)
  }
  
  func startTimer() {
    dashboardView().timerView.start(requestLotStatus, updateInterval: 60)
  }
  
  func stopTimer() {
    dashboardView().timerView.stop()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    stopTimer()
  }
    
  func dashboardView() -> DashboardView {
    return self.view as! DashboardView
  }
    
  func requestLotStatus() {
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = NSLocalizedString("Requesting Lot Status", comment: "")
    
    ApiClient.requestQueueLength { length in
      
      hud.hide(true)
      
      if let length = length {
        self.dashboardView().updateSpots(length.longQueueLength)
        
      } else if !self.errorShown
        && self.tabBarController?.selectedIndex == MainTabs.Lot.rawValue
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

extension DashboardVC: ReachabilityNotifiable {
  func notify(reachability: ReachabilityType) {
    self.dashboardView().notify(reachability)
  }
}
