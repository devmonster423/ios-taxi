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
  private let estimatedTimeLabel = UILabel()
  private let estimatedTimeTitleLabel = UILabel()
  private let flightNumberLabel = UILabel()
  private let scheduledTimeLabel = UILabel()
  private let scheduledTimeTitleLabel = UILabel()
  private let separatorView = UIView()
  private let statusImageView = UIImageView()
  private let statusLabel = UILabel()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // add necessary subviews
    addSubview(airlineImageView)
    addSubview(airlineLabel)
    addSubview(estimatedTimeLabel)
    addSubview(estimatedTimeTitleLabel)
    addSubview(flightNumberLabel)
    addSubview(scheduledTimeLabel)
    addSubview(scheduledTimeTitleLabel)
    addSubview(statusImageView)
    addSubview(statusLabel)
    
    // airline icon imageview
    airlineImageView.contentMode = .ScaleAspectFit
    airlineImageView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.bottom.equalTo(self).offset(-UiConstants.FlightCell.standardMargin)
      make.leading.equalTo(self).offset(UiConstants.FlightCell.standardMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.airlineIconWidth)
    }
    
    // airline
    airlineLabel.sizeToFit()
    airlineLabel.numberOfLines = 0
    airlineLabel.font = self.contentView.bounds.size.width <= UiConstants.FlightCell.iPhone5Width
      ? UiConstants.FlightCell.fontSmallish : UiConstants.FlightCell.fontNormal
    airlineLabel.textColor = Color.Sfo.blue
    airlineLabel.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.snp_centerY)
      make.leading.equalTo(airlineImageView.snp_trailing).offset(UiConstants.FlightCell.bigMargin)
      make.trailing.equalTo(scheduledTimeTitleLabel.snp_leading).offset(-UiConstants.FlightCell.bigMargin)
    }

    // flight #
    flightNumberLabel.numberOfLines = 0
    flightNumberLabel.font = self.contentView.bounds.size.width <= UiConstants.FlightCell.iPhone5Width
      ? UiConstants.FlightCell.fontSmallish : UiConstants.FlightCell.fontNormal
    flightNumberLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.snp_centerY)
      make.leading.equalTo(airlineLabel)
      make.width.equalTo(airlineLabel)
    }
    
    // scheduled time title
    scheduledTimeTitleLabel.textAlignment = .Right
    scheduledTimeTitleLabel.textColor = Color.Sfo.blue
    scheduledTimeTitleLabel.font = UiConstants.FlightCell.fontNormal
    scheduledTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.snp_centerY)
      make.trailing.equalTo(scheduledTimeLabel.snp_leading).offset(-2)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.timesTitleWidth)
    }
    
    // estimated time title
    estimatedTimeTitleLabel.textAlignment = .Right
    estimatedTimeTitleLabel.font = UiConstants.FlightCell.fontNormal
    estimatedTimeTitleLabel.textColor = Color.Sfo.blue
    estimatedTimeTitleLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.snp_centerY)
      make.leading.equalTo(scheduledTimeTitleLabel)
      make.trailing.equalTo(scheduledTimeTitleLabel)
    }
    
    // scheduled time
    scheduledTimeLabel.font = UiConstants.FlightCell.fontNormal
    scheduledTimeLabel.textAlignment = .Left
    scheduledTimeLabel.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.snp_centerY)
      make.trailing.equalTo(statusLabel.snp_leading).offset(-UiConstants.FlightCell.standardMargin)
      make.width.equalTo(self).multipliedBy(UiConstants.FlightCell.timesWidth)
    }

    // estimated time
    estimatedTimeLabel.font = UiConstants.FlightCell.fontNormal
    estimatedTimeLabel.textAlignment = .Left
    estimatedTimeLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.snp_centerY)
      make.leading.equalTo(scheduledTimeLabel)
      make.trailing.equalTo(scheduledTimeLabel)
    }
    
    // status image
    statusImageView.contentMode = .ScaleAspectFit
    statusImageView.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.contentView.snp_centerY).offset(UiConstants.FlightCell.statusImageVerticalOffset)
      make.centerX.equalTo(statusLabel)
      make.width.equalTo(UiConstants.FlightCell.statusImageDiameter)
      make.height.equalTo(UiConstants.FlightCell.statusImageDiameter)
    }

    // status label
    statusLabel.font = UiConstants.FlightCell.fontSmall
    statusLabel.sizeToFit()
    statusLabel.textAlignment = .Center
    statusLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(statusImageView.snp_bottom).offset(UiConstants.FlightCell.standardMargin)
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
    
    scheduledTimeTitleLabel.text = self.contentView.bounds.size.width <= UiConstants.FlightCell.iPhone5Width
      ? NSLocalizedString("Sched.:", comment: "") : NSLocalizedString("Scheduled:", comment: "")
    
    estimatedTimeTitleLabel.text = self.contentView.bounds.size.width <= UiConstants.FlightCell.iPhone5Width
      ? NSLocalizedString("Est.:", comment: "") : NSLocalizedString("Estimated:", comment: "")
    
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
    
    let mungedFlightStatus = Flight.mungeStatus(flight.scheduledTime, estimated: flight.estimatedTime)
    switch mungedFlightStatus {
    case .Delayed:
      statusImageView.image = Image.redCircle.image()
      statusLabel.text = NSLocalizedString("Delayed", comment: "").uppercaseString
      statusLabel.textColor = Color.FlightStatus.delayed
    case .OnTime:
      statusImageView.image = Image.blueCircle.image()
      statusLabel.text = NSLocalizedString("On Time", comment: "").uppercaseString
      statusLabel.textColor = Color.FlightStatus.onTime
    case .Landing:
      statusImageView.image = Image.greenCircle.image()
      statusLabel.text = NSLocalizedString("Landing", comment: "").uppercaseString
      statusLabel.textColor = Color.FlightStatus.landing
    case .Landed:
      statusImageView.image = Image.greenCircle.image()
      statusLabel.text = NSLocalizedString("Landed", comment: "").uppercaseString
      statusLabel.textColor = Color.FlightStatus.landed
    }
  }
}
