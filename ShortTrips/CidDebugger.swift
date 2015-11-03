//
//  CidDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

protocol CidDebugger { }

extension CidDebugger where Self: DebugVC {
  
  func setupCidObservers() {
    paymentCidRead = NotificationObserver(notification: SfoNotification.Cid.payment, handler: { cid, _ in
      self.debugView().printDebugLine("payment cid read detected: (\(cid)")
      self.updateFakeButton("Latest Avi Read At Taxi Loop", action: "latestAviReadAtTaxiLoop")
    })
  }
  
  func fakeCidPayment() {
    let cid = Cid(cidId: 12, cidLocation: "Payment Gate")
    LatestCidIsPaymentCid.sharedInstance.fire(cid)
  }
  
  func triggerEntryCid() {
    LatestCidIsEntryCid.sharedInstance.fire()
  }
}
