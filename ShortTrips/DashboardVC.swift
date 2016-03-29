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
    dashboardView.timerView.start(requestLotStatus, updateInterval: 60)
//#if DEBUG
//    let secretSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: "openDebugMode")
//    secretSwipeRecognizer.numberOfTouchesRequired = 2
//    secretSwipeRecognizer.direction = .Down
//    dashboardView.addGestureRecognizer(secretSwipeRecognizer)
//#endif
    view = dashboardView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "";
    requestLotStatus()
    configureNavBar(title: NSLocalizedString("Holding Lot", comment: "").uppercaseString)
    addSettingsButton()
  }
    
  func dashboardView() -> DashboardView {
    return self.view as! DashboardView
  }
    
  func requestLotStatus() {
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = NSLocalizedString("Requesting Lot Status", comment: "")
    
    ApiClient.requestQueueLengthAndCapacity { info in
      
      hud.hide(true)
      
      if let info = info {
        self.dashboardView().updateSpots(length: info.length, capacity: info.capacity)
        
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
