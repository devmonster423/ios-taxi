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
  @IBOutlet var titleLabel: UILabel!
    
  func displayFlightTableTitle(delay: Double, terminal: TerminalId, var hour: Float) {
    var title: String = ""
    if hour < 0.0 {
      hour = hour * -1.0
      switch terminal {
      case .One:
        title = String(format: NSLocalizedString("Term. One %.1f Hours Ago", comment: ""), hour)
      case .Two:
        title = String(format: NSLocalizedString("Term. Two %.1f Hours Ago", comment: ""), hour)
      case .Three:
        title = String(format: NSLocalizedString("Term. Three %.1f Hours Ago", comment: ""), hour)
      case .International:
        title = String(format: NSLocalizedString("Inter. Term. %.1f Hours Ago", comment: ""), hour)
      }
    }
    else if hour > 0.0 {
      switch terminal {
      case .One:
        title = String(format: NSLocalizedString("Term. One in %.1f Hours", comment: ""), hour)
      case .Two:
        title = String(format: NSLocalizedString("Term. Two in %.1f Hours", comment: ""), hour)
      case .Three:
        title = String(format: NSLocalizedString("Term. Three in %.1f Hours", comment: ""), hour)
      case .International:
        title = String(format: NSLocalizedString("Inter. Term. in %.1f Hours", comment: ""), hour)
      }
    }
    else if hour == 0.0 {
      switch terminal {
      case .One:
        title = NSLocalizedString("Term. One Currently", comment: "")
      case .Two:
        title = NSLocalizedString("Term. Two Currently", comment: "")
      case .Three:
        title = NSLocalizedString("Term. Three Currently", comment: "")
      case .International:
        title = NSLocalizedString("Inter. Term. Currently", comment: "")
      }
    }
    titleLabel.text = title
    delayedLabel.text = String(format: "%.1f", delay * 100.0)
    delayedLabel.text = delayedLabel.text! + NSLocalizedString("% Delayed Flights", comment: "")
  }
}