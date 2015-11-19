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

    associatingDriverAndVehicleAtEntry = NotificationObserver(notification: SfoNotification.State.associatingDriverAndVehicleAtEntry, handler: { _, _ in
      self.debugView().printDebugLine("Associating Driver And Vehicle")
      self.debugView().updateState("Associating Driver And Vehicle")
      self.updateFakeButtons((title: "Associate Driver And Vehicle", action: "associateDriverAndVehicle"))
    })

    associatingDriverAndVehicleAtHoldingLotExit = NotificationObserver(notification: SfoNotification.State.associatingDriverAndVehicleAtHoldingLotExit, handler: { _, _ in
      self.debugView().printDebugLine("Associating Driver And Vehicle")
      self.debugView().updateState("Associating Driver And Vehicle")
      self.updateFakeButtons((title: "Associate Driver And Vehicle", action: "associateDriverAndVehicle"))
    })

    enteredNotReadyState = NotificationObserver(notification: SfoNotification.State.notReady, handler: { _, _ in
      self.debugView().printDebugLine("Entered Not Ready State")
      self.debugView().updateState("Not Ready")
      self.updateFakeButtons((title: "Fake Inside SFO", action: "triggerInsideSfo"))
    })
    
    enteredReadyState = NotificationObserver(notification: SfoNotification.State.ready, handler: { _, _ in
      self.debugView().printDebugLine("Entered Ready State")
      self.debugView().updateState("Ready")
      self.updateFakeButtons((title: "Fake Leaving Outside SFO", action: "fakeOutsideSfo"))
    })
    
    inProgressState = NotificationObserver(notification: SfoNotification.State.inProgress, handler: { _, _ in
      self.debugView().printDebugLine("Entered InProgress State")
      self.debugView().updateState("InProgress")
      
      self.updateFakeButtons((title: "Drop Passenger", action: "dropPassenger"),
        second: (title: "Outside Geofences", action: "fakeOutsideGeofences"),
        third: (title: "Timeout", action: "fakeTimeExpired"))
    })
    
    startingToWaitInHoldingLot = NotificationObserver(notification: SfoNotification.State.waitInHoldingLot, handler: { _, _ in
      self.debugView().printDebugLine("starting to wait")
      self.debugView().updateState("Waiting In Holding Lot")
      self.updateFakeButtons((title: "Fake At Terminal Exit", action: "triggerAtTerminalExit"))
    })
    
    validatingTrip = NotificationObserver(notification: SfoNotification.State.validatingTrip) { _, _ in
      self.debugView().updateState("Validating Trip")
      self.debugView().printDebugLine("Validating Trip")
    }
    
    waitForEntryCidObserver = NotificationObserver(notification: SfoNotification.State.waitForEntryCid) { _, _ in
      self.debugView().printDebugLine("Entered Waiting for Entry Cid")
      self.debugView().updateState("Waiting for Entry Cid")
      self.updateFakeButtons((title:"Trigger Cid Entry", action: "triggerEntryCid"))
    }
    
    waitForEntryGateAviObserver = NotificationObserver(notification: SfoNotification.State.waitForEntryGateAvi) { _, _ in
      self.debugView().printDebugLine("Entered Waiting for Entry Gate Avi")
      self.debugView().updateState("Waiting for Entry Gate Avi")
      self.updateFakeButtons((title: "Confirm Entry Gate Avi Read", action: "confirmEntryGateAviRead"))
    }
    
    waitForPaymentCid = NotificationObserver(notification: SfoNotification.State.waitForPaymentCid, handler: { antenna, _ in
      self.debugView().printDebugLine("Entered Waiting for Payment Cid")
      self.debugView().updateState("Waiting for Payment Cid")
      self.updateFakeButtons((title: "Fake Cid Payment", action: "fakeCidPayment"))
    })
    
    waitForExitAvi = NotificationObserver(notification: SfoNotification.State.waitForExitAvi, handler: { antenna, _ in
      self.debugView().printDebugLine("Entered Waiting for Exit Avi")
      self.debugView().updateState("Waiting for Exit Avi")
      self.updateFakeButtons((title: "Fake Exit AVI Read", action: "latestExitAviRead"))
    })
    
    waitForTaxiLoopAvi = NotificationObserver(notification: SfoNotification.State.waitForTaxiLoopAvi, handler: { antenna, _ in
      self.debugView().printDebugLine("Entered Waiting For Taxi Loop Avi")
      self.debugView().updateState("Waiting for Taxi Loop Avi")
      self.updateFakeButtons((title: "Latest Avi Read At Taxi Loop", action: "latestAviReadAtTaxiLoop"))
    })
    
    waitForTripToStart = NotificationObserver(notification: SfoNotification.State.waitForTripToStart, handler: { antenna, _ in
      self.debugView().printDebugLine("Entered Waiting For Trip to Start")
      self.debugView().updateState("Waiting for Trip to Start")
      self.updateFakeButtons((title: "Generate Trip ID & Start", action: "generateTripId"))
    })
    
    waitForInboundAvi = NotificationObserver(notification: SfoNotification.State.waitForInboundAvi, handler: { antenna, _ in
      self.debugView().printDebugLine("Entered Waiting For Inbound Avi")
      self.debugView().updateState("Waiting for Inbound Avi")
      self.updateFakeButtons((title: "Fake Inbound Avi Read", action: "fakeInboundAviread"))
    })
  }
}
