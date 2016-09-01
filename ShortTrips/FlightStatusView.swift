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
  private let tableHeader = UILabel()
  private let flightTable = UITableView()
  private let timerView = TimerView()
  private let reachabilityNotice = ReachabilityNotice()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
  
    addSubview(tableHeader)
    addSubview(flightTable)
    addSubview(timerView)
    addSubview(tableHeader)
    
    let divider = UIView()
    divider.backgroundColor = Color.Sfo.blue
    addSubview(divider)
    divider.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(1)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(self)
    }
    
    tableHeader.font = UiConstants.FlightStatus.tableHeaderFont
    tableHeader.backgroundColor = Color.NavBar.subtitleBlue
    tableHeader.textColor = Color.FlightStatus.tableHeader
    tableHeader.textAlignment = .Center
    tableHeader.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(UiConstants.FlightStatus.tableHeaderHeight)
      make.top.equalTo(divider.snp_bottom)
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.bottom.equalTo(flightTable.snp_top)
    }
    
    flightTable.separatorStyle = .None
    flightTable.allowsSelection = false
    flightTable.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.bottom.equalTo(timerView.snp_top).offset(-5)
    }
    
    timerView.snp_makeConstraints { (make) -> Void in
      make.bottom.equalTo(self)
      make.height.equalTo(UiConstants.Dashboard.progressHeight)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }

    reachabilityNotice.hidden = ReachabilityManager.sharedInstance.isReachable()
    addSubview(reachabilityNotice)
    reachabilityNotice.snp_makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(UiConstants.ReachabilityNotice.height)
    }
  }

  func setReachabilityNoticeHidden(hidden: Bool) {
    reachabilityNotice.hidden = hidden
  }

  func setupTableView(dataSource dataSource: UITableViewDataSource?, delegate: UITableViewDelegate?, cellClasses:[(AnyClass, String)]) {
    flightTable.dataSource = dataSource
    flightTable.delegate = delegate
    for cellClass in cellClasses {
      flightTable.registerClass(cellClass.0, forCellReuseIdentifier: cellClass.1)
    }
  }

  func startTimerView(updateInterval: NSTimeInterval, callback: TimerCallback) {
    timerView.start(updateInterval, callback: callback)
  }

  func stopTimerView() {
    timerView.stop()
  }

  func setHeaderText(text: String?) {
    tableHeader.text = text
  }

  func reloadTableData() {
    flightTable.reloadData()
  }
}
