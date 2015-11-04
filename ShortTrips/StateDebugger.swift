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
      self.updateFakeButton("Fake Leaving Outside SFO", action: "fakeOutsideSfo")
    })
    
    inProgressState = NotificationObserver(notification: SfoNotification.State.inProgress, handler: { _, _ in
      self.debugView().printDebugLine("Entered InProgress State")
    })
    
    startingToWait = NotificationObserver(notification: SfoNotification.State.wait, handler: { _, _ in
      self.debugView().printDebugLine("starting to wait")
      self.updateFakeButton("Fake At Terminal Exit", action: "triggerAtTerminalExit")
    })
    
    waitForEntryCidObserver = NotificationObserver(notification: SfoNotification.State.waitForEntryCid) { _, _ in
      self.debugView().printDebugLine("Entered Waiting for Entry Cid")
      self.updateFakeButton("Trigger Cid Entry", action: "triggerEntryCid")
    }
    
    waitForEntryGateAviObserver = NotificationObserver(notification: SfoNotification.State.waitForEntryGateAvi) { _, _ in
      self.debugView().printDebugLine("Entered Waiting for Entry Gate Avi")
      self.updateFakeButton("Confirm Entry Gate Avi Read", action: "confirmEntryGateAviRead")
    }
    
    waitForPaymentCid = NotificationObserver(notification: SfoNotification.State.waitForPaymentCid, handler: { antenna, _ in
      self.debugView().printDebugLine("Entered Waiting for Payment Cid")
      self.updateFakeButton("Fake Cid Payment", action: "fakeCidPayment")
    })
    
    waitForExitAvi = NotificationObserver(notification: SfoNotification.State.waitForExitAvi, handler: { antenna, _ in
      self.debugView().printDebugLine("Entered Waiting for Exit Avi")
      self.updateFakeButton("Fake Exit AVI Read", action: "latestExitAviRead")
    })
    
    waitForTaxiLoopAvi = NotificationObserver(notification: SfoNotification.State.waitForTaxiLoopAvi, handler: { antenna, _ in
      self.debugView().printDebugLine("Entered Waiting For Taxi Loop Avi")
      self.updateFakeButton("Latest Avi Read At Taxi Loop", action: "latestAviReadAtTaxiLoop")
    })
  }
}
