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

  var selectedTerminalId: TerminalId?
  var flightStatusVC: FlightStatusVC?
  var currentTime: Float?
  
  @IBOutlet var ontime1Label: UILabel!
  @IBOutlet var delayed1Label: UILabel!
  @IBOutlet var ontime2Label: UILabel!
  @IBOutlet var delayed2Label: UILabel!
  @IBOutlet var ontime3Label: UILabel!
  @IBOutlet var delayed3Label: UILabel!
  @IBOutlet var ontime4Label: UILabel!
  @IBOutlet var delayed4Label: UILabel!
  
  @IBOutlet var terminal1Button: UIButton!
  @IBOutlet var terminal2Button: UIButton!
  @IBOutlet var terminal3Button: UIButton!
  @IBOutlet var terminal4Button: UIButton!
  
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var timeSlider: UISlider!
  @IBOutlet var updateLabel: UILabel!
  @IBOutlet var updateProgress: UIProgressView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    configureTitle()
    navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor(CGColor: UiConstants.SfoColorWithAlpha)!), forBarMetrics: .Default)
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
  
  func configureTitle() {
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 30))
    titleLabel.text = NSLocalizedString("Terminals", comment: "")
    titleLabel.textAlignment = .Center
    titleLabel.font = UIFont(name: UiConstants.navControllerFont, size: UiConstants.navControllerFontSizeNormal)!
    titleLabel.textColor = UIColor.whiteColor()
    
    navigationItem.titleView = titleLabel
  }
  
  func updateTerminalTable() {
    
    if let currentTime = currentTime {
      SfoInfoRequester.requestTerminals ({ (terminals, error) -> Void in
        if let terminals = terminals {
          println("terminal 0 delayed count: \(terminals[0].delayedCount)")
          self.reloadViews(terminals)
        }
        else {
          println("error: \(error)")
          let terminals = [
            TerminalSummary(terminalId: TerminalId.International, count: 2, delayedCount: 3),
            TerminalSummary(terminalId: TerminalId.One, count: 3, delayedCount: 2),
            TerminalSummary(terminalId: TerminalId.Two, count: 5, delayedCount: 4),
            TerminalSummary(terminalId: TerminalId.Three, count: 7, delayedCount: 6)
          ]
          self.reloadViews(terminals)
        }
        }, hour: currentTime)
    }
  }
  
  @IBAction func updateTime() {
    let newTime: Float = timeSlider.value
    if newTime > currentTime! + UiConstants.timeTolerance || newTime < currentTime! - UiConstants.timeTolerance {
      if newTime < 0.0 {
        timeLabel.text = String(format: NSLocalizedString("Terminal Status %.1f Hours Ago", comment: ""), newTime * -1.0)
      }
      else if newTime > 0.0 {
        timeLabel.text = String(format: NSLocalizedString("Terminal Status %.1f Hours in the Future", comment: ""), newTime)
      }
      else if newTime == 0.0 {
        timeLabel.text = String(format: NSLocalizedString("Current Terminal Status", comment: ""), newTime)
      }
      currentTime = newTime
      updateTerminalTable()
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    flightStatusVC = segue.destinationViewController as? FlightStatusVC

    if let flightStatusVC = flightStatusVC {
      flightStatusVC.currentTime = currentTime
      
      switch sender as! UIButton {
      case terminal1Button:
        flightStatusVC.selectedTerminalId = .One
      case terminal2Button:
        flightStatusVC.selectedTerminalId = .Two
      case terminal3Button:
        flightStatusVC.selectedTerminalId = .Three
      case terminal4Button:
        flightStatusVC.selectedTerminalId = .International
      default:
        assertionFailure("unknown sender")
      }
    }
  }
  
  func reloadViews(summaries: [TerminalSummary]) {
    
    ontime1Label.text = "\(summaries[0].count)"
    delayed1Label.text = "\(summaries[0].delayedCount)"
    
    ontime2Label.text = "\(summaries[1].count)"
    delayed2Label.text = "\(summaries[1].delayedCount)"
    
    ontime3Label.text = "\(summaries[2].count)"
    delayed3Label.text = "\(summaries[2].delayedCount)"
    
    ontime4Label.text = "\(summaries[3].count)"
    delayed4Label.text = "\(summaries[3].delayedCount)"
  }
}
