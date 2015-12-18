//
//  StateShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit
import TransitionKit

extension ShortTripVC {
  
  func setupStateObservers() {
    
    sfoObservers.stateUpdateObserver = NotificationObserver(notification: SfoNotification.State.update) { state, _ in
      self.updateForState(state)
    }
  }
  
  func updateForState(state: TKState) {
    if state == AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState() {
        self.shortTripView().notificationLabel.text = "Associating Driver And Vehicle"
        self.shortTripView().notificationImageView.image = Image.sfoTime.image()
        
    } else if state == NotReady.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Not Ready State"
      self.shortTripView().currentStateLabel.text = "Not Ready"
      self.shortTripView().notificationImageView.image = Image.thumbsdown.image()
      
    } else if state == Ready.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Ready State"
      self.shortTripView().currentStateLabel.text = "Ready"
      self.shortTripView().notificationImageView.image = Image.thumbsup.image()
      
    } else if state == InProgress.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered InProgress State"
      self.shortTripView().currentStateLabel.text = "InProgress"
      self.shortTripView().notificationImageView.image = Image.taxicab.image()
      
    } else if state == WaitingInHoldingLot.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Waiting in holding lot"
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
      
    } else if state == ValidatingTrip.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Validating Trip"
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
      
    } else if state == WaitingForEntryCid.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Waiting for Entry CID"
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
      
    } else if state == WaitingForEntryAvi.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Waiting for Entry Gate AVI"
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
      
    } else if state == WaitingForPaymentCid.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Waiting for Payment CID"
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
      
    } else if state == WaitingForExitAvi.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Waiting for Exit AVI"
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
      
      self.sfoObservers.notInTerminalExitObserver = NotificationObserver(notification: SfoNotification.Geofence.notInTerminalExit) { _, _ in
        self.shortTripView().notificationLabel.text = "Not Exiting Terminals"
        self.sfoObservers.notInTerminalExitObserver = nil
      }
    } else if state == WaitingForTaxiLoopAvi.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Waiting For Taxi Loop AVI"
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
      
    } else if state == WaitingForStartTrip.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Waiting For Trip to Start"
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
    }
  }
}
