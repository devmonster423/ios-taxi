//
//  TerminalCell.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/15/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit

class TerminalCell: UITableViewCell {
  @IBOutlet var terminalLabel: UILabel!
  @IBOutlet var countLabel: UILabel!
  @IBOutlet var delayedLabel: UILabel!

  func setTerminalSummary(terminalSummary: TerminalSummary) {
    terminalLabel.text = "Term: \(terminalSummary.terminalId.rawValue)"
    countLabel.text = "Count: \(terminalSummary.count)"
    delayedLabel.text = "Delayed: \(terminalSummary.delayedCount)"
  }
}
