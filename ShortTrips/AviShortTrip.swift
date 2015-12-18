//
//  AviShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupAviObservers() {
    
    sfoObservers.entryGateAvi = NotificationObserver(notification: SfoNotification.Avi.entryGate) { antenna, _ in
      self.shortTripView().notificationLabel.text = "Entry Gate AVI Detected"
    }
    
    sfoObservers.exitAviRead = NotificationObserver(notification: SfoNotification.Avi.exit) { antenna, _ in
      self.shortTripView().notificationLabel.text = "Exit AVI Detected"
    }
    
    sfoObservers.taxiLoopAviRead = NotificationObserver(notification: SfoNotification.Avi.taxiLoop) { antenna, _ in
      self.shortTripView().notificationLabel.text = "Taxiloop AVI Detected"
    }
  }
}