//
//  TerminalSummaryVC.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import UIKit

class TerminalSummaryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var terminals: [Terminal]?
  var selectedTerminalId: TerminalId?
  var flightStatusVC: FlightStatusVC?
  var currentTime: Float?
  
  
  @IBOutlet var terminalTable: UITableView!
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var timeSlider: UISlider!
  @IBOutlet var updateLabel: UILabel!
  @IBOutlet var updateProgress: UIProgressView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    terminalTable.delegate = self
    terminalTable.dataSource = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    currentTime = timeSlider.value
    updateTerminalTable()
    UpdateTimer.start(updateProgress, updateLabel: updateLabel, callback: updateTerminalTable)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    UpdateTimer.stop()
  }
  
  func updateTerminalTable() {
    SfoInfoRequester.requestTerminals ({ (terminals, error) -> Void in
      if let terminals = terminals {
        println("terminal 0 delayed count: \(terminals[0].delayedCount)")
        self.terminals = terminals
      }
      else {
        println("error: \(error)")
        self.terminals = [Terminal(terminalId: TerminalId.International, count: 2, delayedCount: 3),
          Terminal(terminalId: TerminalId.One, count: 3, delayedCount: 2),
          Terminal(terminalId: TerminalId.Two, count: 5, delayedCount: 4),
          Terminal(terminalId: TerminalId.Three, count: 7, delayedCount: 6)]
      }
      self.terminalTable.reloadData()
    }, hour: currentTime!)
  }
  
  @IBAction func updateTime() {
    let newTime: Float = timeSlider.value
    if newTime > currentTime! + UiConstants.timeTolerance || newTime < currentTime! - UiConstants.timeTolerance {
      if newTime < 0.0 {
        timeLabel.text = String(format: NSLocalizedString("Terminal Status %.01f Hours Ago", comment: ""), newTime * -1.0)
      }
      else if newTime > 0.0 {
        timeLabel.text = String(format: NSLocalizedString("Terminal Status %.01f Hours in the Future", comment: ""), newTime)
      }
      else if newTime == 0.0 {
        timeLabel.text = String(format: NSLocalizedString("Current Terminal Status", comment: ""), newTime)
      }
      currentTime = newTime
      updateTerminalTable()
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "show flights" {
      flightStatusVC = segue.destinationViewController as? FlightStatusVC
    }
  }
  
  // MARK: UITableView
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if terminals == nil {
      return 0
    }
    else {
      return terminals!.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("terminalCell") as? TerminalCell
    cell?.setTerminal(terminals![indexPath.row])
    return cell!
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    flightStatusVC!.selectedTerminalId = terminals![indexPath.row].terminalId
    flightStatusVC!.currentTime = currentTime
  }
}