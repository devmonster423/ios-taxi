//
//  CidDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupCidObservers() {
    entryCidRead = NotificationObserver(notification: SfoNotification.Cid.entry, handler: { cid, _ in
      self.debugView().printDebugLine("entry cid read detected: (\(cid)")
    })
    
    paymentCidRead = NotificationObserver(notification: SfoNotification.Cid.payment, handler: { cid, _ in
      self.debugView().printDebugLine("payment cid read detected: (\(cid)")
      self.updateFakeButton("Latest Avi Read At Taxi Loop", action: "latestAviReadAtTaxiLoop")
    })
  }
  
  func fakeCidPayment() {
    let cid = Cid(cidId: "CID12", cidLocation: "Payment Gate", cidTimeRead: NSDate())
    LatestCidIsPaymentCid.sharedInstance.fire(cid)
  }
  
  func triggerEntryCid() {
    let cid = Cid(cidId: "CID10", cidLocation: "Entry Gate", cidTimeRead: NSDate())
    LatestCidIsEntryCid.sharedInstance.fire(cid)
  }
}
