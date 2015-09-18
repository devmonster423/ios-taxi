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
  
  private var airlineIcon = UIImageView()
  private var flightNumberLabel = UILabel()
  private var flightStatusLabel = UILabel()
  private var landingTimeLabel = UILabel()
  
  static let height = 80
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
      make.top.equalTo(self).offset(5)
      make.bottom.equalTo(self).offset(-5)
      make.left.equalTo(self).offset(5)
      make.width.equalTo(90)
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