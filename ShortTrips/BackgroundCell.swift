//
//  BackgroundCell.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/19/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class BackgroundCell: UITableViewCell {
  @IBOutlet var delayedLabel: UILabel!

  func displayDelay(delay: Double) {
    delayedLabel.text = String(format: "%.1f", delay * 100.0)
    delayedLabel.text = delayedLabel.text! + NSLocalizedString("% Delayed Flights", comment: "")
  }
}