//
//  PingShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension ShortTripVC {
  
  func setupPingObservers() {
    sfoObservers.attemptingPingObserver = NotificationObserver(notification: SfoNotification.Ping.attempting) { ping, _ in
      self.shortTripView().notificationLabel.text = "attempting ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
    
    sfoObservers.successfulPingObserver = NotificationObserver(notification: SfoNotification.Ping.successful, handler: { ping, _ in
      self.shortTripView().notificationLabel.text = "successful ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
    
    sfoObservers.unsuccessfulPingObserver = NotificationObserver(notification: SfoNotification.Ping.unsuccessful, handler: { ping, _ in
      self.shortTripView().notificationLabel.text = "Unsuccessful Ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
    
    sfoObservers.validPingObserver = NotificationObserver(notification: SfoNotification.Ping.valid, handler: { ping, _ in
      self.shortTripView().notificationLabel.text = "Valid Ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
    
    sfoObservers.invalidPingObserver = NotificationObserver(notification: SfoNotification.Ping.invalid, handler: { ping, _ in
      self.shortTripView().notificationLabel.text = "Invalid Ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    })
  }
}
