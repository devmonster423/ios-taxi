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
    
    sfoObservers.entryGateAvi = NotificationObserver(notification: SfoNotification.Avi.entryGate, handler: { antenna, _ in
      self.shortTripView().notificationLabel.text = "Entry Gate AVI Detected: \(antenna)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
    
    sfoObservers.exitAviRead = NotificationObserver(notification: SfoNotification.Avi.exit, handler: { antenna, _ in
      self.shortTripView().notificationLabel.text = "Exit AVI Read: (\(antenna)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
    
    sfoObservers.taxiLoopAviRead = NotificationObserver(notification: SfoNotification.Avi.taxiLoop, handler: { antenna, _ in
      self.shortTripView().notificationLabel.text = "Taxiloop AVI Read: (\(antenna)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
    
    sfoObservers.unexpectedAviRead = NotificationObserver(notification: SfoNotification.Avi.unexpected, handler: { gtmsLocations, _ in
      self.shortTripView().notificationLabel.text = "Unexpected AVI - Expected \(gtmsLocations.expected.rawValue), Found \(gtmsLocations.found.rawValue)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
  }
}