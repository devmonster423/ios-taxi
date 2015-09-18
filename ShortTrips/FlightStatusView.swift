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
   
    // TODO: remove
    backgroundColor = UIColor.purpleColor()
  }
}
