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
    let antenna = Antenna(antennaId: "L27AVI1", aviLocation: "Location #27 Taxi Entry", aviDate: NSDate())
    AviManager.sharedInstance.setLatestAviLocation(antenna.device()!)
    LatestAviAtEntry.sharedInstance.fire(antenna)
  }
  
  func confirmReEntryGateAviRead() {
    let antenna = Antenna(antennaId: "L27AVI1", aviLocation: "Location #27 Taxi Entry", aviDate: NSDate())
    AviManager.sharedInstance.setLatestAviLocation(antenna.device()!)
    LatestAviAtReEntry.sharedInstance.fire(antenna)
  }
  
  func latestAviReadAtTaxiLoop() {
    let antenna = Antenna(antennaId: "L14AVI1", aviLocation: "Location #14 Taxi Loop", aviDate: NSDate())
    AviManager.sharedInstance.setLatestAviLocation(antenna.device()!)
    LatestAviAtTaxiLoop.sharedInstance.fire(antenna)
  }

  func latestDomExitAviRead() {
    let antenna = Antenna(antennaId: "L2AVI1", aviLocation: "Location #2 Domestic Exit", aviDate: NSDate())
    AviManager.sharedInstance.setLatestAviLocation(antenna.device()!)
    ExitAviCheckComplete.sharedInstance.fire(antenna)
  }
}
