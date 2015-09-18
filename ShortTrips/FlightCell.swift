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
  
  let dateFormatter = NSDateFormatter()
  let standardMargin = 5
  
  private var airlineIcon = UIImageView()
  private var flightNumberLabel = UILabel()
  private var flightStatusLabel = UILabel()
  private var landingTimeLabel = UILabel()
  
  static let height: CGFloat = 80
  static let identifier = "flightCell"
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(airlineIcon)
    addSubview(flightNumberLabel)
    addSubview(flightStatusLabel)
    addSubview(landingTimeLabel)
    
    airlineIcon.contentMode = .ScaleAspectFit
    airlineIcon.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(standardMargin)
      make.bottom.equalTo(self).offset(-standardMargin)
      make.left.equalTo(self)
      make.width.equalTo(self).dividedBy(4)
    }
    
    flightNumberLabel.textAlignment = .Center
    flightNumberLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(standardMargin)
      make.bottom.equalTo(self).offset(-standardMargin)
      make.left.equalTo(airlineIcon.snp_right)
      make.width.equalTo(self).dividedBy(4)
    }
    
    flightStatusLabel.textAlignment = .Center
    flightStatusLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(standardMargin)
      make.bottom.equalTo(self).offset(-standardMargin)
      make.left.equalTo(flightNumberLabel.snp_right)
      make.width.equalTo(self).dividedBy(4)
    }
    
    landingTimeLabel.textAlignment = .Center
    landingTimeLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(standardMargin)
      make.bottom.equalTo(self).offset(-standardMargin)
      make.left.equalTo(flightStatusLabel.snp_right)
      make.width.equalTo(self).dividedBy(4)
    }
  }
  
  func displayFlight(flight: Flight) {
    airlineIcon.image = flight.airline.icon()
    flightNumberLabel.text = "#\(flight.flightNumber)"
    if dateFormatter.dateFormat == "" {
      dateFormatter.dateFormat = "hh:mm a"
    }
    landingTimeLabel.text = dateFormatter.stringFromDate(flight.landingTime)
    flightStatusLabel.text = NSLocalizedString(flight.flightStatus!.rawValue, comment: "")
    flightStatusLabel.textColor = flight.flightStatus.getStatusColor()
    landingTimeLabel.textColor = flight.flightStatus.getTimeOrFlightNumberColor()
    flightNumberLabel.textColor = flight.flightStatus.getTimeOrFlightNumberColor()
  }
}