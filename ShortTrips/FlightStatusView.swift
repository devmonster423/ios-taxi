//
//  FlightStatusView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class FlightStatusView: UIView {
  
  let flightTable = UITableView()
  let timerView = TimerView()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.whiteColor()
    flightTable.separatorColor = Color.FlightStatus.separator
    flightTable.separatorStyle = .None
    addSubview(flightTable)
    addSubview(timerView)
    
    flightTable.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self)
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.bottom.equalTo(timerView.snp_top).offset(-5)
    }
    
    timerView.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.height.equalTo(60)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
  }
}
