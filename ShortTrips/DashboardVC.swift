//
//  DashboardVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
  @IBOutlet var colorView: UIView!
  @IBOutlet var directionLabel: UIView!
  @IBOutlet var statusButton: UIButton!
  @IBOutlet var comeToSfoLabel: UILabel!
  @IBOutlet var explanationLabel: UILabel!
  @IBOutlet var updateLabel: UILabel!
  @IBOutlet var updateProgress: UIProgressView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statusButton.layer.cornerRadius = UiConstants.statusCornerRadius
    statusButton.layer.borderWidth = UiConstants.statusBorderWidth
    statusButton.layer.borderColor = UiConstants.SfoColor
    navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    navigationItem.title = "";
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    requestLotStatus()
    UpdateTimer.start(updateProgress, updateLabel: updateLabel, callback: requestLotStatus)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    UpdateTimer.stop()
  }
  
  func requestLotStatus() {
    SfoInfoRequester.requestLotStatus { (status, error) -> Void in
      if let status = status, let lotStatus = status.lotStatus {
        self.comeToSfoLabel.text = NSLocalizedString(lotStatus.rawValue, comment: "")
      } else {
        self.comeToSfoLabel.text = NSLocalizedString("maybe", comment: "")
      }
    }
  }
}
