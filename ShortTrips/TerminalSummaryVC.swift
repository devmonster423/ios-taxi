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
/*
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selectedRun = indexPath.row
    if logType == .History {
      performSegueWithIdentifier("pan details from log", sender: self)
    }
    else if logType == .Simulate {
      performSegueWithIdentifier("pan run from log", sender: self)
    }
  }
*/
/*
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "pan details from log" {
      var runDetailsVC: RunDetailsVC = segue.destinationViewController as! RunDetailsVC
      runDetailsVC.run = runs[selectedRun]
      runDetailsVC.logType = .History
    }
    else {
      if segue.identifier == "pan run from log" {
        var runVC: RunVC = segue.destinationViewController as! RunVC
        runVC.runToSimulate = runs[selectedRun]
      }
    }
  }
*/
}