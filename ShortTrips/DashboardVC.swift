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
  
  override func loadView() {
    let dashboardView = DashboardView(frame: UIScreen.mainScreen().bounds)
    dashboardView.timerView.start(requestLotStatus, updateInterval: 60)
    let secretSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: "openDebugMode")
    secretSwipeRecognizer.numberOfTouchesRequired = 2
    secretSwipeRecognizer.direction = .Down
    dashboardView.addGestureRecognizer(secretSwipeRecognizer)
    view = dashboardView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "";
    requestLotStatus()
    configureNavBar(title: NSLocalizedString("Dashboard", comment: "").uppercaseString)
    addLogoutButton()
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
        self.dashboardView().updateSpots(info)
        
      } else if self.navigationController?.visibleViewController == self {
          UiHelpers.displayErrorMessage(self, message: NSLocalizedString("An error occurred while fetching parking-lot data.", comment: ""))
      }
    }
  }
  
  func openDebugMode() {
    navigationController?.pushViewController(DebugVC(), animated: true)
  }
}
