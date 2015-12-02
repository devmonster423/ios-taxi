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
      self.shortTripView().notificationLabel.text = "Entry CID Read Detected"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.paymentCidRead = NotificationObserver(notification: SfoNotification.Cid.payment) { cid, _ in
      self.shortTripView().notificationLabel.text = "Payment CID Read Detected"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.unexpectedCidRead = NotificationObserver(notification: SfoNotification.Cid.unexpected, handler: { cidDevices, _ in
      self.shortTripView().notificationLabel.text = "Unexpected CID - Expected \(cidDevices.expected.rawValue), found \(cidDevices.found.rawValue)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
  }
}
