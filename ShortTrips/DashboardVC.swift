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
    dashboardView.terminalStatusBtn.addTarget(self,
      action: "showTerminalStatus",
      forControlEvents: .TouchUpInside)
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
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.translucent = true
    navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    navigationController?.navigationBar.shadowImage = UIImage()
  }
  
  func dashboardView() -> DashboardView {
    return self.view as! DashboardView
  }
    
  func requestLotStatus() {
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    hud.labelText = NSLocalizedString("Requesting Lot Status", comment: "")
    ApiClient.requestLotStatus({ (status, error) -> Void in
      
      hud.hide(true)
      if let color = status?.color  {
        self.dashboardView().updateStatusUI(color)
      }
      else {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""),
          message: NSLocalizedString("An error occurred while fetching parking-lot data.", comment: ""),
          preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
          style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    })
  }
  
  func openDebugMode() {
    navigationController?.pushViewController(LoginVC(), animated: true)
  }

  func showTerminalStatus() {
    navigationController?.pushViewController(TerminalSummaryVC(), animated: true)
  }
}
