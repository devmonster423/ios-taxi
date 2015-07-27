//
//  ViewController.swift
//  ShortTrips
//
//  Created by Matt Luedke on 7/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var statusButton: UIButton!
  private class var statusCornerRadius : CGFloat { return 15.0 }
  private class var statusBorderWidth : CGFloat { return 1.0 }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statusButton.layer.cornerRadius = ViewController.statusCornerRadius
    statusButton.layer.borderWidth = ViewController.statusBorderWidth
    statusButton.layer.borderColor = view.tintColor.CGColor
  }
}
