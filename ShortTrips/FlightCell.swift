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
  private var estimatedTimeLabel = UILabel()
  private var flightNumberLabel = UILabel()
  private var flightStatusLabel = UILabel()
  
  static let height: CGFloat = 80
  static let identifier = "flightCell"
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(airlineIcon)
    addSubview(estimatedTimeLabel)
    addSubview(flightNumberLabel)
    addSubview(flightStatusLabel)
    
    airlineIcon.contentMode = .ScaleAspectFit
    airlineIcon.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(standardMargin)
      make.bottom.equalTo(self).offset(-standardMargin)
      make.left.equalTo(self)
      make.width.equalTo(self).dividedBy(4)
    }
    
    estimatedTimeLabel.font = Font.MyriadProBold.size(13)
    estimatedTimeLabel.textAlignment = .Center
    estimatedTimeLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(standardMargin)
      make.bottom.equalTo(self).offset(-standardMargin)
      make.left.equalTo(flightStatusLabel.snp_right)
      make.width.equalTo(self).dividedBy(4)
    }

    flightNumberLabel.font = Font.MyriadPro.size(15)
    flightNumberLabel.textAlignment = .Center
    flightNumberLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(standardMargin)
      make.bottom.equalTo(self).offset(-standardMargin)
      make.left.equalTo(airlineIcon.snp_right)
      make.width.equalTo(self).dividedBy(4)
    }
    
    flightStatusLabel.font = Font.MyriadPro.size(15)
    flightStatusLabel.textAlignment = .Center
    flightStatusLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self).offset(standardMargin)
      make.bottom.equalTo(self).offset(-standardMargin)
      make.left.equalTo(flightNumberLabel.snp_right)
      make.width.equalTo(self).dividedBy(4)
    }
  }
  
  func displayFlight(flight: Flight) {
    
    let scale = UIScreen.mainScreen().scale
    let width = airlineIcon.bounds.size.width * scale
    let height = airlineIcon.bounds.size.height * scale
    self.airlineIcon.image = nil
    Airline.loadImageForAirline(flight.airline, width: Int(width), height: Int(height)) {
      image in
      
      self.airlineIcon.image = image
    }
    
    // TODO: get icon for airline
    flightNumberLabel.text = "#\(flight.flightNumber)"
    if dateFormatter.dateFormat == "" {
      dateFormatter.dateFormat = "hh:mm a"
    }
    estimatedTimeLabel.text = dateFormatter.stringFromDate(flight.estimatedTime)

    if let flightStatus = flight.flightStatus {
      estimatedTimeLabel.textColor = flightStatus.getTimeOrFlightNumberColor()
      flightNumberLabel.textColor = flightStatus.getTimeOrFlightNumberColor()
      flightStatusLabel.textColor = flightStatus.getStatusColor()
      flightStatusLabel.text = NSLocalizedString(flightStatus.rawValue, comment: "")
    } else {
      estimatedTimeLabel.textColor = Color.FlightStatus.standard
      flightNumberLabel.textColor = Color.FlightStatus.standard
      flightStatusLabel.text = ""
    }
  }
}
