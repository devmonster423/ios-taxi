//
//  StateDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupStateObservers() {
    associatingDriverAndVehicle = NotificationObserver(notification: SfoNotification.State.associatingDriverAndVehicle, handler: { _, _ in
      self.debugView().printDebugLine("Associating Driver And Vehicle")
      self.updateFakeButton("Associate Driver And Vehicle", action: "associateDriverAndVehicle")
    })
    
    enteredNotReadyState = NotificationObserver(notification: SfoNotification.State.notReady, handler: { _, _ in
      self.debugView().printDebugLine("Entered Not Ready State")
    })
    
    enteredReadyState = NotificationObserver(notification: SfoNotification.State.ready, handler: { _, _ in
      self.debugView().printDebugLine("Entered Ready State")
      self.updateFakeButton("Start Ride", action: "leaveTerminalExitLoop")
    })
    
    inProgressState = NotificationObserver(notification: SfoNotification.State.inProgress, handler: { _, _ in
      self.debugView().printDebugLine("Entered InProgress State")
    })
    
    startingToWait = NotificationObserver(notification: SfoNotification.State.wait, handler: { _, _ in
      self.debugView().printDebugLine("starting to wait")
      self.updateFakeButton("Fake At Terminal Exit", action: "triggerAtTerminalExit")
    })
    
    waitForEntryCidObserver = NotificationObserver(notification: SfoNotification.State.waitForEntryCid) { _, _ in
      self.updateFakeButton("Trigger Cid Entry", action: "triggerEntryCid")
    }
    
    waitForEntryGateAviObserver = NotificationObserver(notification: SfoNotification.State.waitForEntryGateAvi) { _, _ in
      self.updateFakeButton("Confirm Entry Gate Avi Read", action: "confirmEntryGateAviRead")
    }
  }
}
