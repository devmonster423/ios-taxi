//
//  StateDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

extension DebugVC {  
  func updateForState(_ state: TKState) {
    if state == AssociatingDriverAndVehicleAtEntry.sharedInstance.getState() {
      debugView().printDebugLine("Associating Driver And Vehicle")
      debugView().updateState("Associating Driver And Vehicle")
      updateFakeButtons((title: "Associate Driver And Vehicle", action: #selector(DebugVC.associateDriverAndVehicle)), second: (title: "Inside Taxi Loop Exit", action: #selector(DebugVC.triggerAtTerminalExit)))

    } else if state == AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState() {
      debugView().printDebugLine("Associating Driver And Vehicle")
      debugView().updateState("Associating Driver And Vehicle")
      updateFakeButtons((title: "Associate Driver And Vehicle", action: #selector(DebugVC.associateDriverAndVehicle)))
      
    } else if state == AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState() {
      debugView().printDebugLine("Associating Driver And Vehicle")
      debugView().updateState("Associating Driver And Vehicle")
      updateFakeButtons((title: "Associate Driver And Vehicle", action: #selector(DebugVC.associateDriverAndVehicle)))
      
    } else if state == GpsIsOff.sharedInstance.getState() {
      debugView().printDebugLine("Gps is off")
      debugView().updateState("gps is off")
      updateFakeButtons((title: "fake gps back on", action: #selector(DebugVC.fakeGpsOn)))
      
    } else if state == NotReady.sharedInstance.getState() {
      debugView().printDebugLine("Entered Not Ready State")
      debugView().updateState("Not Ready")
      updateFakeButtons((title: "Fake Inside Taxi Waiting Zone", action: #selector(DebugVC.triggerInsideTaxiWaitingZone)), second: (title: "Inside Taxi Loop Exit", action: #selector(DebugVC.triggerAtTerminalExit)), third: (title: "Dom. Departure", action: #selector(DebugVC.triggerAtDomesticDropoff)))
      
    } else if state == Ready.sharedInstance.getState() {
      debugView().printDebugLine("Entered Ready State")
      debugView().updateState("Ready")
      updateFakeButtons((title: "outOfBufferedExit", action: #selector(DebugVC.outOfBufferedExit)))
      
    } else if state == InProgress.sharedInstance.getState() {
      debugView().printDebugLine("Entered InProgress State")
      debugView().updateState("InProgress")
      updateFakeButtons((title: "Drop Passenger", action: #selector(DebugVC.dropPassenger)),
        second: (title: "Outside Geofences", action: #selector(DebugVC.fakeOutsideGeofences)),
        third: (title: "Timeout", action: #selector(DebugVC.fakeTimeExpired)))
      
    } else if state == WaitingInHoldingLot.sharedInstance.getState() {
      debugView().printDebugLine("starting to wait in holding lot")
      debugView().updateState("Waiting In Holding Lot")
      updateFakeButtons((title: "Fake At Terminal Exit", action: #selector(DebugVC.triggerAtTerminalExit)), second: (title: "outOfBufferedExit", action:
      #selector(DebugVC.outOfBufferedExit)))
      
    } else if state == ValidatingTrip.sharedInstance.getState() {
      debugView().updateState("Validating Trip")
      debugView().printDebugLine("Validating Trip")
    
    } else if state == WaitingForEntryCid.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting for Entry Cid")
      debugView().updateState("Waiting for Entry Cid")
      updateFakeButtons((title:"Trigger Cid Entry", action: #selector(DebugVC.triggerEntryCid)), second: (title: "Inside Taxi Loop Exit", action: #selector(DebugVC.triggerAtTerminalExit)), third: (title: "Out of WaitingZone", action: #selector(DebugVC.triggerOutsideTaxiWaitingZone)))
      
    } else if state == WaitingForReEntryCid.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting for ReEntry Cid")
      debugView().updateState("Waiting for ReEntry Cid")
      updateFakeButtons((title:"Trigger Cid ReEntry", action: #selector(DebugVC.triggerReEntryCid)))
      
    } else if state == WaitingForEntryAvi.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting for Entry Gate Avi")
      debugView().updateState("Waiting for Entry Gate Avi")
      updateFakeButtons((title: "Confirm Entry Gate Avi Read", action: #selector(DebugVC.confirmEntryGateAviRead)), second: (title: "Inside Taxi Loop Exit", action: #selector(DebugVC.triggerAtTerminalExit)))
      
    } else if state == WaitingForReEntryAvi.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting for ReEntry Gate Avi")
      debugView().updateState("Waiting for ReEntry Gate Avi")
      updateFakeButtons((title: "Confirm ReEntry Gate Avi Read", action: #selector(DebugVC.confirmReEntryGateAviRead)), second: (title: "outOfBufferedExit", action: #selector(DebugVC.outOfBufferedExit)))
      
    } else if state == WaitingForPaymentCid.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting for Payment Cid")
      debugView().updateState("Waiting for Payment Cid")
      updateFakeButtons((title: "Fake Cid Payment", action: #selector(DebugVC.fakeCidPayment)), second: (title: "OutsideDomExit", action: #selector(DebugVC.triggerOutsideDomesticTerminalExit)))
      
    } else if state == WaitingForExitAvi.sharedInstance.getState() {
      self.debugView().printDebugLine("Entered Waiting for Exit Avi")
      self.debugView().updateState("Waiting for Exit Avi")
      self.updateFakeButtons((title: "Fake Dom Exit AVI Read", action: #selector(DebugVC.latestDomExitAviRead)))
      
    } else if state == WaitingForTaxiLoopAvi.sharedInstance.getState() {
      debugView().printDebugLine("Entered Waiting For Taxi Loop Avi")
      debugView().updateState("Waiting for Taxi Loop Avi")
      updateFakeButtons((title: "Latest Avi Read At Taxi Loop", action: #selector(DebugVC.latestAviReadAtTaxiLoop)))
      
    } else if state == StartingTrip.sharedInstance.getState() {
      debugView().printDebugLine("Entered Starting Trip")
      debugView().updateState("Starting Trip")
      updateFakeButtons((title: "Generate Trip ID & Start", action: #selector(DebugVC.generateTripId)))
    }
  }
}
