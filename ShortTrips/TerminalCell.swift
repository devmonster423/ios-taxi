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

  func setTerminal(terminal: Terminal) {
    terminalLabel.text = "Term: \(terminal.terminalId!.rawValue)"
    countLabel.text = "Count: \(terminal.count!)"
    delayedLabel.text = "Delayed: \(terminal.delayedCount!)"
  }
}
