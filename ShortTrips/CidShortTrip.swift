//
//  CidShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupCidObservers() {
    
    sfoObservers.entryCidRead = NotificationObserver(notification: SfoNotification.Cid.entry) { cid, _ in
      self.shortTripView().notify(NSLocalizedString("Entry CID Read Detected", comment: ""))
    }
    
    sfoObservers.paymentCidRead = NotificationObserver(notification: SfoNotification.Cid.payment) { cid, _ in
      self.shortTripView().notify(NSLocalizedString("Payment CID Read Detected", comment: ""))
    }
  }
}
