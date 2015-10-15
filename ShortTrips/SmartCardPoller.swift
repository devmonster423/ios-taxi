//
//  SmartCardPoller.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/15/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

class SmartCardPoller {

  static var timer: NSTimer?

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

  private static func check() {
    ApiClient.requestCidForSmartCard(TripManager.sharedInstance.getCurrentDriver().cardId)
      { cid in

        if let cid = cid where
        cid.cidLocation == "entry" {

          LatestCidIsEntryCid.sharedInstance.fire()
        }
    }
  }
}
