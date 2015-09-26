//
//  FlightCell.swift
//  ShortTrips
//
//  Created by Joshua Adams on 7/31/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class FlightCell: UITableViewCell {
  private let dateFormatter = NSDateFormatter()
  private var airlineIcon = UIImageView(image: UIImage(named: "unknownAirline"))
  private var airlineAndFlightLabel = UILabel()
  private var timesTitleLabel = UILabel()
  private var timesLabel = UILabel()
  private var statusButton = UIButton()
  private var estimatedTimeLabel = UILabel()
  private var flightNumberLabel = UILabel()
  private var flightStatusLabel = UILabel()
  private let separatorView = UIView()
  static let identifier = "flightCell"
  private static var lastCellWasWhite = false
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    // airline icon
    addSubview(airlineIcon)
    airlineIcon.contentMode = .ScaleAspectFit
    airlineIcon.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.bottom.equalTo(self).offset(-UiConstants.FlightCell.standardMargin)
      make.leading.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.airlineIconWidth)
    }
    
    // airline and flight #
    addSubview(airlineAndFlightLabel)
    airlineAndFlightLabel.numberOfLines = 0
    if UIScreen.mainScreen().bounds.size.width <= UiConstants.FlightCell.iPhone5Width {
      airlineAndFlightLabel.font = UiConstants.FlightCell.fontSmallish
    }
    else {
      airlineAndFlightLabel.font = UiConstants.FlightCell.fontNormal
    }
    airlineAndFlightLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.bottom.equalTo(self).offset(-UiConstants.FlightCell.standardMargin)
      make.leading.equalTo(airlineIcon.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.airlineAndFlightWidth)
    }
    
    // scheduled-and-estimated-time title
    addSubview(timesTitleLabel)
    timesTitleLabel.numberOfLines = 0
    timesTitleLabel.font = UiConstants.FlightCell.fontNormal
    if UIScreen.mainScreen().bounds.size.width <= UiConstants.FlightCell.iPhone5Width {
      timesTitleLabel.text = NSLocalizedString("Sched.:\nEst.:", comment: "")
    }
    else {
      timesTitleLabel.text = NSLocalizedString("Scheduled:\nEstimated:", comment: "")
    }
    let attrText = NSMutableAttributedString(string: timesTitleLabel.text!)
    attrText.addAttribute(NSForegroundColorAttributeName, value: Color.Sfo.blue, range: NSMakeRange(0, attrText.length))
    timesTitleLabel.attributedText = attrText
    timesTitleLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.bottom.equalTo(self).offset(-UiConstants.FlightCell.standardMargin)
      make.leading.equalTo(airlineAndFlightLabel.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.timesTitleWidth)
    }

    // scheduled and estimated time
    addSubview(timesLabel)
    timesLabel.numberOfLines = 0
    timesLabel.font = UiConstants.FlightCell.fontNormal
    timesLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.bottom.equalTo(self).offset(-UiConstants.FlightCell.standardMargin)
      make.leading.equalTo(timesTitleLabel.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.timesWidth)
    }
    
    // status
    addSubview(statusButton)
    statusButton.titleLabel?.font = UiConstants.FlightCell.fontSmall
    statusButton.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.bottom.equalTo(self).offset(-UiConstants.FlightCell.standardMargin)
      make.trailing.equalTo(self).offset(-UiConstants.FlightCell.standardMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.statusWidth)
    }
    
    // separator
    separatorView.backgroundColor = Color.FlightStatus.separator
    addSubview(separatorView)
    separatorView.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(UiConstants.FlightCell.separatorHeight)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
  }
  
  func displayFlight(flight: Flight) {
    if FlightCell.lastCellWasWhite {
      self.backgroundColor = Color.FlightCell.background
    }
    airlineAndFlightLabel.text = "\(flight.airline.uppercaseString)\n\(flight.flightNumber)"
    let nsAirlineAndFlightLabelText = airlineAndFlightLabel.text! as NSString
    let attributedString = NSMutableAttributedString(string: nsAirlineAndFlightLabelText as String)
    attributedString.addAttribute(NSForegroundColorAttributeName, value: Color.Sfo.blue, range: nsAirlineAndFlightLabelText.rangeOfString(flight.airline.uppercaseString))
    airlineAndFlightLabel.attributedText = attributedString
    if dateFormatter.dateFormat == "" {
      dateFormatter.dateFormat = NSLocalizedString("h:mma", comment: "")
      dateFormatter.AMSymbol = NSLocalizedString("am", comment: "")
      dateFormatter.PMSymbol = NSLocalizedString("pm", comment: "")
    }
    timesLabel.text = "\(dateFormatter.stringFromDate(flight.scheduledTime))\n\(dateFormatter.stringFromDate(flight.estimatedTime))"
    statusButton.hidden = false
    if let flightStatus = flight.flightStatus {
      switch flightStatus {
      case .Delayed:
        statusButton.setImage(UIImage(named: "red_circle"), forState: UIControlState.Normal)
        statusButton.setTitle(NSLocalizedString("Delayed", comment: "").uppercaseString, forState: UIControlState.Normal)
        statusButton.setTitleColor(Color.FlightStatus.delayed, forState: UIControlState.Normal)
      case .OnTime:
        statusButton.setImage(UIImage(named: "blue_circle"), forState: UIControlState.Normal)
        statusButton.setTitle(NSLocalizedString("On Time", comment: "").uppercaseString, forState: UIControlState.Normal)
        statusButton.setTitleColor(Color.FlightStatus.onTime, forState: UIControlState.Normal)
      case .Landing:
        statusButton.setImage(UIImage(named: "green_circle"), forState: UIControlState.Normal)
        statusButton.setTitle(NSLocalizedString("Landing", comment: "").uppercaseString, forState: UIControlState.Normal)
        statusButton.setTitleColor(Color.FlightStatus.landing, forState: UIControlState.Normal)
      case .Landed:
        statusButton.setImage(UIImage(named: "green_circle"), forState: UIControlState.Normal)
        statusButton.setTitle(NSLocalizedString("Landed", comment: "").uppercaseString, forState: UIControlState.Normal)
        statusButton.setTitleColor(Color.FlightStatus.landed, forState: UIControlState.Normal)
      }
      statusButton.centerLabelVerticallyWithPadding(UiConstants.FlightCell.statusPadding)
    } else {
      statusButton.hidden = true
    }
    FlightCell.lastCellWasWhite = !FlightCell.lastCellWasWhite
  }
}
