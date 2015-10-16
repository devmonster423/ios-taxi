//
//  SmartCardPoller.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

class SmartCardPoller: NSObject {

  private static var timer: NSTimer?

  static func start() {
    timer = NSTimer.scheduledTimerWithTimeInterval(5,
      target: self,
      selector: "check",
      userInfo: nil,
      repeats: true)
  }

  static func stop() {
    self.timer?.invalidate()
    self.timer = nil
  }

  static func check() {
    
    if let driver = TripManager.sharedInstance.getCurrentDriver() {
      ApiClient.requestCidForSmartCard(driver.cardId) { cid in
          
          // TODO: actually verify if the CID is the entry CID
          //        if let cid = cid where
          //        cid.cidLocation == "entry" {
          
          LatestCidIsEntryCid.sharedInstance.fire()
          //  }
      }
    }
  }
}
