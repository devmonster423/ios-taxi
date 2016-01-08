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
    
    sfoObservers.entryGateAvi = NotificationObserver(notification: SfoNotification.Avi.entryGate, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("entry gate avi detected: (\(antenna)")
      self.debugView().incrementGtms()
    })
    
    sfoObservers.domExitAviRead = NotificationObserver(notification: SfoNotification.Avi.domExit, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("Domestic Exit AVI read: (\(antenna)")
      self.debugView().incrementGtms()
    })
    
    sfoObservers.domReEntryAvi = NotificationObserver(notification: SfoNotification.Avi.domesticReEntry, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("Domestic ReEntry AVI read: (\(antenna)")
      self.debugView().incrementGtms()
    })
    
    sfoObservers.intlArrivalExitAvi = NotificationObserver(notification: SfoNotification.Avi.intlArrivalExit, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("Intl Arrival Exit AVI: (\(antenna)")
      self.debugView().incrementGtms()
    })
    
    sfoObservers.taxiLoopAviRead = NotificationObserver(notification: SfoNotification.Avi.taxiLoop, handler: { antenna, _ in
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("Taxiloop AVI read: (\(antenna)")
      self.debugView().incrementGtms()
    })
    
    sfoObservers.unexpectedAviRead = NotificationObserver(notification: SfoNotification.Avi.unexpected, handler: { gtmsLocations, _ in
      self.debugView().printDebugLine("unexpected avi. expected \(gtmsLocations.expected.rawValue), found \(gtmsLocations.found.rawValue)", type: .Negative)
      self.debugView().updateAvi("\(gtmsLocations.found.rawValue)")
      self.debugView().incrementGtms()
    })
  }
  
  func confirmEntryGateAviRead() {
    LatestAviAtEntry.sharedInstance.fire(Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: NSDate()))
  }
  
  func confirmReEntryGateAviRead() {
    LatestAviAtReEntry.sharedInstance.fire(Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: NSDate()))
  }
  
  func latestAviReadAtTaxiLoop() {
    LatestAviAtTaxiLoop.sharedInstance.fire(Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: NSDate()))
  }

  func latestExitAviRead() {
    LatestAviAtDomExit.sharedInstance.fire(Antenna(antennaId: "123", aviLocation: "Location #15 Taxi Main Lot", aviDate: NSDate()))
  }
}
