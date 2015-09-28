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
  private var airlineLabel = UILabel()
  private var flightNumberLabel = UILabel()
  private var scheduledTimeTitleLabel = UILabel()
  private var estimatedTimeTitleLabel = UILabel()
  private var scheduledTimeLabel = UILabel()
  private var estimatedTimeLabel = UILabel()
  private var statusButton = UIButton()
  private let separatorView = UIView()
  static let identifier = "flightCell"
  
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
    
    // airline
    addSubview(airlineLabel)
    airlineLabel.sizeToFit()
    airlineLabel.numberOfLines = 0
    if UIScreen.mainScreen().bounds.size.width <= UiConstants.FlightCell.iPhone5Width {
      airlineLabel.font = UiConstants.FlightCell.fontSmallish
      flightNumberLabel.font = UiConstants.FlightCell.fontSmallish
    }
    else {
      airlineLabel.font = UiConstants.FlightCell.fontNormal
      flightNumberLabel.font = UiConstants.FlightCell.fontNormal
    }
    airlineLabel.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.snp_centerY)
      make.leading.equalTo(airlineIcon.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.airlineAndFlightWidth)
    }

    // flight #
    addSubview(flightNumberLabel)
    flightNumberLabel.numberOfLines = 0
    flightNumberLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.snp_centerY)
      make.leading.equalTo(airlineIcon.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.airlineAndFlightWidth)
    }
    
    // scheduled time title
    addSubview(scheduledTimeTitleLabel)
    scheduledTimeTitleLabel.numberOfLines = 0
    scheduledTimeTitleLabel.textAlignment = .Right
    scheduledTimeTitleLabel.font = UiConstants.FlightCell.fontNormal
    if UIScreen.mainScreen().bounds.size.width <= UiConstants.FlightCell.iPhone5Width {
      scheduledTimeTitleLabel.text = NSLocalizedString("Sched.:", comment: "")
      estimatedTimeTitleLabel.text = NSLocalizedString("Est.:", comment: "")
    }
    else {
      scheduledTimeTitleLabel.text = NSLocalizedString("Scheduled:", comment: "")
      estimatedTimeTitleLabel.text = NSLocalizedString("Estimated:", comment: "")
    }
    let attrTextScheduled = NSMutableAttributedString(string: scheduledTimeTitleLabel.text!)
    attrTextScheduled.addAttribute(NSForegroundColorAttributeName, value: Color.Sfo.blue, range: NSMakeRange(0, attrTextScheduled.length))
    scheduledTimeTitleLabel.attributedText = attrTextScheduled
    scheduledTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.snp_centerY)
      make.leading.equalTo(airlineLabel.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.timesTitleWidth)
    }
    
    // estimated time label
    addSubview(estimatedTimeTitleLabel)
    estimatedTimeTitleLabel.numberOfLines = 0
    estimatedTimeTitleLabel.textAlignment = .Right
    estimatedTimeTitleLabel.font = UiConstants.FlightCell.fontNormal
    let attrTextEstimated = NSMutableAttributedString(string: estimatedTimeTitleLabel.text!)
    attrTextEstimated.addAttribute(NSForegroundColorAttributeName, value: Color.Sfo.blue, range: NSMakeRange(0, attrTextEstimated.length))
    estimatedTimeTitleLabel.attributedText = attrTextEstimated
    estimatedTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.snp_centerY)
      make.leading.equalTo(flightNumberLabel.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.timesTitleWidth)
    }
    
    // scheduled time
    addSubview(scheduledTimeLabel)
    scheduledTimeLabel.font = UiConstants.FlightCell.fontNormal
    scheduledTimeLabel.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.snp_centerY)
      make.leading.equalTo(scheduledTimeTitleLabel.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.timesWidth)
    }

    // estimated time
    addSubview(estimatedTimeLabel)
    estimatedTimeLabel.font = UiConstants.FlightCell.fontNormal
    estimatedTimeLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.snp_centerY)
      make.leading.equalTo(estimatedTimeTitleLabel.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
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
  
  func displayFlight(flight: Flight, darkBackground: Bool) {
    if darkBackground {
      self.backgroundColor = Color.FlightCell.darkBackground
    }
    else {
      self.backgroundColor = Color.FlightCell.lightBackground
    }
    
    let scale = UIScreen.mainScreen().scale
    let width = airlineIcon.bounds.size.width * scale
    let height = airlineIcon.bounds.size.height * scale
    self.airlineIcon.image = nil
        Flight.airlineImageForFlight(flight.flightNumber, width: Int(width), height: Int(height)) { image in
      self.airlineIcon.image = image
    }    
    airlineLabel.text = "\(flight.airline.uppercaseString)"
    let nsAirlineLabelText = airlineLabel.text! as NSString
    let attributedString = NSMutableAttributedString(string: nsAirlineLabelText as String)
    attributedString.addAttribute(NSForegroundColorAttributeName, value: Color.Sfo.blue, range: nsAirlineLabelText.rangeOfString(flight.airline.uppercaseString))
    airlineLabel.attributedText = attributedString
    
    flightNumberLabel.text = "#\(flight.flightNumber)"
    
    if dateFormatter.dateFormat == "" {
      dateFormatter.dateFormat = NSLocalizedString("h:mma", comment: "")
      dateFormatter.AMSymbol = NSLocalizedString("am", comment: "")
      dateFormatter.PMSymbol = NSLocalizedString("pm", comment: "")
    }
    scheduledTimeLabel.text = dateFormatter.stringFromDate(flight.scheduledTime)
    estimatedTimeLabel.text = dateFormatter.stringFromDate(flight.estimatedTime)
    
    statusButton.hidden = false
    let mungedFlightStatus: FlightStatus
    if let flightStatus = flight.flightStatus {
      mungedFlightStatus = Flight.mungeStatus(flightStatus, scheduled: flight.scheduledTime, estimated: flight.estimatedTime)
    }
    else {
      mungedFlightStatus = Flight.mungeStatus(flight.scheduledTime, estimated: flight.estimatedTime)
    }
    switch mungedFlightStatus {
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
  }
}
