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
  private static let dateFormatter = NSDateFormatter()
  
  static let identifier = "flightCell"
  
  private let airlineImageView = UIImageView()
  private let airlineLabel = UILabel()
  private let flightNumberLabel = UILabel()
  private let scheduledTimeLabel = UILabel()
  private let estimatedTimeLabel = UILabel()
  private let statusButton = UIButton()
  private let separatorView = UIView()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    // airline icon imageview
    addSubview(airlineImageView)
    airlineImageView.contentMode = .ScaleAspectFit
    airlineImageView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.bottom.equalTo(self).offset(-UiConstants.FlightCell.standardMargin)
      make.leading.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.airlineIconWidth)
    }
    
    // airline
    addSubview(airlineLabel)
    airlineLabel.sizeToFit()
    airlineLabel.numberOfLines = 0
    airlineLabel.font = self.contentView.bounds.size.width <= UiConstants.FlightCell.iPhone5Width
      ? UiConstants.FlightCell.fontSmallish : UiConstants.FlightCell.fontNormal
    airlineLabel.textColor = Color.Sfo.blue
    airlineLabel.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.snp_centerY)
      make.leading.equalTo(airlineImageView.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.airlineAndFlightWidth)
    }

    // flight #
    addSubview(flightNumberLabel)
    flightNumberLabel.numberOfLines = 0
    flightNumberLabel.font = self.contentView.bounds.size.width <= UiConstants.FlightCell.iPhone5Width
      ? UiConstants.FlightCell.fontSmallish : UiConstants.FlightCell.fontNormal
    flightNumberLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.snp_centerY)
      make.leading.equalTo(airlineImageView.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.airlineAndFlightWidth)
    }
    
    // scheduled time title
    let scheduledTimeTitleLabel = UILabel()
    addSubview(scheduledTimeTitleLabel)
    scheduledTimeTitleLabel.numberOfLines = 0
    scheduledTimeTitleLabel.textAlignment = .Right
    scheduledTimeTitleLabel.textColor = Color.Sfo.blue
    scheduledTimeTitleLabel.font = UiConstants.FlightCell.fontNormal
    scheduledTimeTitleLabel.text = self.contentView.bounds.size.width <= UiConstants.FlightCell.iPhone5Width
      ? NSLocalizedString("Sched.:", comment: "") : NSLocalizedString("Scheduled:", comment: "")
    scheduledTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.snp_centerY)
      make.leading.equalTo(airlineLabel.snp_trailingMargin).offset(UiConstants.FlightCell.bigMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.timesTitleWidth)
    }
    
    // estimated time label
    let estimatedTimeTitleLabel = UILabel()
    addSubview(estimatedTimeTitleLabel)
    estimatedTimeTitleLabel.numberOfLines = 0
    estimatedTimeTitleLabel.textAlignment = .Right
    estimatedTimeTitleLabel.font = UiConstants.FlightCell.fontNormal
    estimatedTimeTitleLabel.textColor = Color.Sfo.blue
    estimatedTimeTitleLabel.text = self.contentView.bounds.size.width <= UiConstants.FlightCell.iPhone5Width
      ? NSLocalizedString("Est.:", comment: "") : NSLocalizedString("Estimated:", comment: "")
    estimatedTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.snp_centerY)
      make.leading.equalTo(scheduledTimeTitleLabel)
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
    
    self.backgroundColor = darkBackground ? Color.FlightCell.darkBackground : Color.FlightCell.lightBackground
    
    let scale = UIScreen.mainScreen().scale
    let width = airlineImageView.bounds.size.width * scale
    let height = airlineImageView.bounds.size.height * scale
    self.airlineImageView.image = nil
    Flight.airlineImageForFlight(flight.flightNumber, width: Int(width), height: Int(height)) { image in
      self.airlineImageView.image = image
    }
    
    airlineLabel.text = flight.airline.uppercaseString
    
    flightNumberLabel.text = "#\(flight.flightNumber)"
    
    if FlightCell.dateFormatter.dateFormat == "" {
      FlightCell.dateFormatter.dateFormat = NSLocalizedString("h:mma", comment: "")
      FlightCell.dateFormatter.AMSymbol = NSLocalizedString("am", comment: "")
      FlightCell.dateFormatter.PMSymbol = NSLocalizedString("pm", comment: "")
    }
    scheduledTimeLabel.text = FlightCell.dateFormatter.stringFromDate(flight.scheduledTime)
    estimatedTimeLabel.text = FlightCell.dateFormatter.stringFromDate(flight.estimatedTime)
    
    statusButton.hidden = false
    let mungedFlightStatus = Flight.mungeStatus(flight.scheduledTime, estimated: flight.estimatedTime)
    switch mungedFlightStatus {
    case .Delayed:
      statusButton.setImage(Image.redCircle.image(), forState: UIControlState.Normal)
      statusButton.setTitle(NSLocalizedString("Delayed", comment: "").uppercaseString, forState: UIControlState.Normal)
      statusButton.setTitleColor(Color.FlightStatus.delayed, forState: UIControlState.Normal)
    case .OnTime:
      statusButton.setImage(Image.blueCircle.image(), forState: UIControlState.Normal)
      statusButton.setTitle(NSLocalizedString("On Time", comment: "").uppercaseString, forState: UIControlState.Normal)
      statusButton.setTitleColor(Color.FlightStatus.onTime, forState: UIControlState.Normal)
    case .Landing:
      statusButton.setImage(Image.greenCircle.image(), forState: UIControlState.Normal)
      statusButton.setTitle(NSLocalizedString("Landing", comment: "").uppercaseString, forState: UIControlState.Normal)
      statusButton.setTitleColor(Color.FlightStatus.landing, forState: UIControlState.Normal)
    case .Landed:
      statusButton.setImage(Image.greenCircle.image(), forState: UIControlState.Normal)
      statusButton.setTitle(NSLocalizedString("Landed", comment: "").uppercaseString, forState: UIControlState.Normal)
      statusButton.setTitleColor(Color.FlightStatus.landed, forState: UIControlState.Normal)
    }
    statusButton.centerLabelVerticallyWithPadding(UiConstants.FlightCell.statusPadding)
  }
}
