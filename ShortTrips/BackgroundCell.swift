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
    delayedLabel.text = String(format: NSLocalizedString("%.1f%% Delayed Flights", comment: ""), delay * 100.0)
  }
}