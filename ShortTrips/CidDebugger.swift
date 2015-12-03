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
    
    sfoObservers.entryCidRead = NotificationObserver(notification: SfoNotification.Cid.entry) { cid, _ in
      self.debugView().updateCid("\(cid)")
      self.debugView().printDebugLine("entry cid read detected")
      self.debugView().incrementGtms()
    }
    
    sfoObservers.paymentCidRead = NotificationObserver(notification: SfoNotification.Cid.payment) { cid, _ in
      self.debugView().updateCid("\(cid)")
      self.debugView().printDebugLine("payment cid read detected")
      self.debugView().incrementGtms()
    }
    
    sfoObservers.unexpectedCidRead = NotificationObserver(notification: SfoNotification.Cid.unexpected, handler: { cidDevices, _ in
      self.debugView().printDebugLine("unexpected cid. expected \(cidDevices.expected.rawValue), found \(cidDevices.found.rawValue)", type: .Negative)
      self.debugView().incrementGtms()
    })
  }
  
  func fakeCidPayment() {
    let cid = Cid(cidId: "456", cidLocation: "payment", cidTimeRead: NSDate())
    LatestCidIsPaymentCid.sharedInstance.fire(cid)
  }
  
  func triggerEntryCid() {
    let cid = Cid(cidId: "123", cidLocation: "entry", cidTimeRead: NSDate())
    LatestCidIsEntryCid.sharedInstance.fire(cid)
  }
}
