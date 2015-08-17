//
//  TerminalSummaryVC.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class TerminalSummaryVC: UIViewController {
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    SfoInfoRequester.requestTerminals { (terminals, error) -> Void in
      if let terminals = terminals {
        println("terminal 0 delayed count: \(terminals[0].delayedCount)")
      }
      else {
        println("error: \(error)")
      }
    }
  }
}