//
//  StateDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit
import TransitionKit

extension DebugVC {
  
  func setupStateObservers() {
    
    sfoObservers.stateUpdateObserver = NotificationObserver(notification: SfoNotification.State.update) { state, _ in
      self.updateForState(state)
    }
  }
  
  func updateForState(state: TKState) {
    if state == AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState() {
      debugView().printDebugLine("Associating Driver And Vehicle")
      debugView().updateState("Associating Driver And Vehicle")
      updateFakeButtons((title: "Associate Driver And Vehicle", action: "associateDriverAndVehicle"))
      
    } else if state == NotReady.sharedInstance.getState() {
      debugView().printDebugLine("Entered Not Ready State")
      debugView().updateState("Not Ready")
      updateFakeButtons((title: "Fake Inside SFO", action: "triggerInsideSfo"), second: (title: "Inside Taxi Loop Exit", action: "triggerAtTerminalExit"))
      
    } else if state == Ready.sharedInstance.getState() {
      debugView().printDebugLine("Entered Ready State")
      debugView().updateState("Ready")
      updateFakeButtons((title: "Fake Exiting Terminals", action: "fakeExitingTerminals"))
      
    } else if state == InProgress.sharedInstance.getState() {
      debugView().printDebugLine("Entered InProgress State")
      debugView().updateState("InProgress")
      updateFakeButtons((title: "Drop Passenger", action: "dropPassenger"),
        second: (title: "Outside Geofences", action: "fakeOutsideGeofences"),
        third: (title: "Timeout", action: "fakeTimeExpired"))
      
    } else if state == WaitingInHoldingLot.sharedInstance.getState() {
      debugView().printDebugLine("starting to wait in holding lot")
      debugView().updateState("Waiting In Holding Lot")
      updateFakeButtons((title: "Fake At Terminal Exit", action: "triggerAtTerminalExit"))
      
    } else if state == ValidatingTrip.sharedInstance.getState() {
      debugView().updateState("Validating Trip")
      debugView().printDebugLine("Validating Trip")
    
    } else if state == WaitingForEntryCid.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting for Entry Cid")
      debugView().updateState("Waiting for Entry Cid")
      updateFakeButtons((title:"Trigger Cid Entry", action: "triggerEntryCid"))
      
    } else if state == VerifyingEntryGateAvi.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting for Entry Gate Avi")
      debugView().updateState("Waiting for Entry Gate Avi")
      updateFakeButtons((title: "Confirm Entry Gate Avi Read", action: "confirmEntryGateAviRead"), second: (title: "Outside SFO", action: "triggerOutsideSfo"))
      
    } else if state == WaitingForPaymentCid.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting for Payment Cid")
      debugView().updateState("Waiting for Payment Cid")
      updateFakeButtons((title: "Fake Cid Payment", action: "fakeCidPayment"))
      
    } else if state == VerifyingExitAvi.sharedInstance.getState() {
      self.debugView().printDebugLine("Entered Waiting for Exit Avi")
      self.debugView().updateState("Waiting for Exit Avi")
      self.updateFakeButtons((title: "Fake Exit AVI Read", action: "latestExitAviRead"),
        second: (title: "Out of SFO Exit", action: "triggerOutsideSfo"))
      
      sfoObservers.notInTerminalExitObserver = NotificationObserver(notification: SfoNotification.Geofence.notInTerminalExit) { _, _ in
        self.debugView().printDebugLine("not exiting terminals")
        self.sfoObservers.notInTerminalExitObserver = nil
      }
      
    } else if state == VerifyingTaxiLoopAvi.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting For Taxi Loop Avi")
      debugView().updateState("Waiting for Taxi Loop Avi")
      updateFakeButtons((title: "Latest Avi Read At Taxi Loop", action: "latestAviReadAtTaxiLoop"))
      
    } else if state == WaitingForStartTrip.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting For Trip to Start")
      debugView().updateState("Waiting for Trip to Start")
      updateFakeButtons((title: "Generate Trip ID & Start", action: "generateTripId"))
    }
  }
}
