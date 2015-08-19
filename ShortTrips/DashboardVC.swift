//
//  DashboardVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
  @IBOutlet var statusButton: UIButton!
  
  @IBOutlet var comeToSfoLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statusButton.layer.cornerRadius = UiConstants.statusCornerRadius
    statusButton.layer.borderWidth = UiConstants.statusBorderWidth
    statusButton.layer.borderColor = UiConstants.SfoColor
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    navigationController?.navigationBar.shadowImage = UIImage()
    let backButton = UIBarButtonItem(image: UIImage(named: "backButton"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("goBack"))
    
    SfoInfoRequester.requestLotStatus { (status, error) -> Void in
      if status != nil {
        self.comeToSfoLabel.text = NSLocalizedString(status!.lotStatus!.rawValue, comment: "")
      }
      else {
        self.comeToSfoLabel.text = NSLocalizedString("maybe", comment: "")
      }
    }
  }
  
  func goBack() {
    navigationController?.popViewControllerAnimated(true)
  }  
}
