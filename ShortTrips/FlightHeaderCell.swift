//
//  BackgroundCell.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/19/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class FlightHeaderCell: UITableViewCell {

  private var delayedLabel = UILabel()
  
  static let height: CGFloat = 200
  static let identifier = "flightHeaderCell"
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(delayedLabel)
    
    let backgroundImageView = UIImageView()
    backgroundImageView.image = UIImage(named: "backgroundFlights")
    addSubview(backgroundImageView)
    sendSubviewToBack(backgroundImageView)
    backgroundImageView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self)
    }
    
    delayedLabel.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(20)
      make.width.equalTo(200)
      make.bottom.equalTo(self).offset(-60)
      make.centerX.equalTo(self)
    }
  }
    
  func displayDelay(delay: Double) {
    delayedLabel.text = String(format: NSLocalizedString("%.1f%% Delayed Flights", comment: ""), delay * 100.0)
  }
}