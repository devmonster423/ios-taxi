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
      self.debugView().printDebugLine("entry cid read detected")
    })
    
    paymentCidRead = NotificationObserver(notification: SfoNotification.Cid.payment, handler: { cid, _ in
      self.debugView().printDebugLine("payment cid read detected")
    })
    
    unexpectedCidRead = NotificationObserver(notification: SfoNotification.Cid.unexpected, handler: { cidDevices, _ in
      self.debugView().printDebugLine("unexpected cid. expected \(cidDevices.expected.name()), found \(cidDevices.found.name())", type: .Negative)
    })
  }
  
  func fakeCidPayment() {
    LatestCidIsPaymentCid.sharedInstance.fire()
  }
  
  func triggerEntryCid() {
    LatestCidIsEntryCid.sharedInstance.fire()
  }
}
