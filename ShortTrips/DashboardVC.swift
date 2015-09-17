//
//  DashboardVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
  @IBOutlet var backgroundImageView: UIImageView!
  @IBOutlet var directionLabel: UILabel!
  @IBOutlet var statusButton: UIButton!
  @IBOutlet var comeToSfoLabel: UILabel!
  @IBOutlet var explanationLabel: UILabel!
  @IBOutlet var updateLabel: UILabel!
  @IBOutlet var updateProgress: UIProgressView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statusButton.layer.cornerRadius = UiConstants.statusCornerRadius
    statusButton.layer.borderWidth = UiConstants.statusBorderWidth
    statusButton.layer.borderColor = UiConstants.SfoColor.CGColor
    navigationItem.title = "";
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    navigationController?.navigationBar.shadowImage = UIImage()
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
        self.updateStatusUI(lotStatus)
      } else {
        self.updateStatusUI(LotStatus.random())
      }
    }
  }
  
  func updateStatusUI(lotStatus: LotStatus) {
    switch lotStatus {
      
    case .Yes:
      backgroundImageView.image = UIImage(named: "green_bg.jpg")
      comeToSfoLabel.text = NSLocalizedString("Go To SFO", comment: "")
      directionLabel.text = NSLocalizedString(lotStatus.rawValue, comment: "")
      explanationLabel.text = NSLocalizedString("Lot capacity is not full", comment: "")
      
    case .Maybe:
      backgroundImageView.image = UIImage(named: "yellow_bg.jpg")
      comeToSfoLabel.text = NSLocalizedString("Go To SFO", comment: "")
      directionLabel.text = NSLocalizedString(lotStatus.rawValue, comment: "")
      explanationLabel.text = NSLocalizedString("Lot capacity is almost full", comment: "")
      
    case .No:
      backgroundImageView.image = UIImage(named: "red_bg.jpg")
      comeToSfoLabel.text = NSLocalizedString("Don't Go To SFO", comment: "")
      directionLabel.text = NSLocalizedString(lotStatus.rawValue, comment: "")
      explanationLabel.text = NSLocalizedString("Lot capacity is full", comment: "")
    }
  }
}
