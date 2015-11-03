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
      self.debugView().printDebugLine("entry gate avi detected: (\(antenna)")
      self.updateFakeButton("Fake At Terminal Exit", action: "triggerAtTerminalExit")
    })
    
    taxiLoopAviRead = NotificationObserver(notification: SfoNotification.Avi.taxiLoop, handler: { antenna, _ in
      self.debugView().printDebugLine("Taxiloop AVI read: (\(antenna)")
      self.updateFakeButton("Fake Cid Payment", action: "fakeCidPayment")
    })
  }
  
  func confirmEntryGateAviRead() {
    EntryGateAVIReadConfirmed.sharedInstance.fire(Antenna(antennaId: 123, aviLocation: .Entry, aviDate: NSDate()))
  }
  
  func latestAviReadAtTaxiLoop() {
    LatestAviReadAtTaxiLoop.sharedInstance.fire(Antenna(antennaId: 123, aviLocation: .Entry, aviDate: NSDate()))
  }
}
