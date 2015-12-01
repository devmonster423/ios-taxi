//
//  AviDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupAviObservers() {
    
    entryGateAvi = NotificationObserver(notification: SfoNotification.Avi.entryGate, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("entry gate avi detected: (\(antenna)")
    })
    
    exitAviRead = NotificationObserver(notification: SfoNotification.Avi.exit, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("Exit AVI read: (\(antenna)")
    })
    
    inboundAviRead = NotificationObserver(notification: SfoNotification.Avi.exit, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("Inbound AVI read: (\(antenna)")
    })
    
    taxiLoopAviRead = NotificationObserver(notification: SfoNotification.Avi.taxiLoop, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("Taxiloop AVI read: (\(antenna)")
    })
    
    unexpectedAviRead = NotificationObserver(notification: SfoNotification.Avi.unexpected, handler: { gtmsLocations, _ in
      self.debugView().printDebugLine("unexpected avi. expected \(gtmsLocations.expected.rawValue), found \(gtmsLocations.found.rawValue)", type: .Negative)
    })
  }
  
  func confirmEntryGateAviRead() {
    LatestAviReadAtEntry.sharedInstance.fire(Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: NSDate()))
  }
  
  func latestAviReadAtTaxiLoop() {
    LatestAviReadAtTaxiLoop.sharedInstance.fire(Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: NSDate()))
  }

  func latestExitAviRead() {
    LatestAviReadAtExit.sharedInstance.fire(Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: NSDate()))
  }
}
