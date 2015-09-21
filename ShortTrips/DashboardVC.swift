//
//  DashboardVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
  
  override func loadView() {
    let dashboardView = DashboardView(frame: UIScreen.mainScreen().bounds)
    dashboardView.terminalStatusBtn.addTarget(self,
      action: "showTerminalStatus",
      forControlEvents: .TouchUpInside)
    view = dashboardView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "";
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    navigationController?.navigationBar.shadowImage = UIImage()
    requestLotStatus()
    UpdateTimer.start(dashboardView().timerView,
      callback: requestLotStatus)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    UpdateTimer.stop()
  }
  
  func dashboardView() -> DashboardView {
    return self.view as! DashboardView
  }

  func requestLotStatus() {
    SfoInfoRequester.requestLotStatus { (status, error) -> Void in
      if let status = status, let lotStatus = status.lotStatus {
        self.dashboardView().updateStatusUI(lotStatus.lotStatusEnum)
      } else {
        self.dashboardView().updateStatusUI(LotStatusEnum.random())
      }
    }
  }

  func showTerminalStatus() {
    navigationController?.pushViewController(TerminalSummaryVC(), animated: true)
  }
}
