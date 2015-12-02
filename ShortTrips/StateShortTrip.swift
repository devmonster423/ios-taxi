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
        self.shortTripView().currentStateLabel.text = "Associating Driver And Vehicle"
        self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == NotReady.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Not Ready State"
      self.shortTripView().currentStateLabel.text = "Not Ready"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == Ready.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Ready State"
      self.shortTripView().currentStateLabel.text = "Ready"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == InProgress.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered InProgress State"
      self.shortTripView().currentStateLabel.text = "InProgress"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == WaitingInHoldingLot.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "starting to wait in holding lot"
      self.shortTripView().currentStateLabel.text = "Waiting In Holding Lot"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == ValidatingTrip.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Validating Trip"
      self.shortTripView().currentStateLabel.text = "Validating Trip"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == WaitingForEntryCid.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Waiting for Entry CID"
      self.shortTripView().currentStateLabel.text = "Waiting for Entry CID"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == VerifyingEntryGateAvi.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Waiting for Entry Gate AVI"
      self.shortTripView().currentStateLabel.text = "Waiting for Entry Gate AVI"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == WaitingForPaymentCid.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Waiting for Payment CID"
      self.shortTripView().currentStateLabel.text = "Waiting for Payment CID"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == VerifyingExitAvi.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Waiting for Exit AVI"
      self.shortTripView().currentStateLabel.text = "Waiting for Exit AVI"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
      self.sfoObservers.notInTerminalExitObserver = NotificationObserver(notification: SfoNotification.Geofence.notInTerminalExit) { _, _ in
        self.shortTripView().notificationLabel.text = "Not Exiting Terminals"
        self.sfoObservers.notInTerminalExitObserver = nil
      }
    } else if state == VerifyingTaxiLoopAvi.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Waiting For Taxi Loop AVI"
      self.shortTripView().currentStateLabel.text = "Waiting for Taxi Loop AVI"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    } else if state == WaitingForStartTrip.sharedInstance.getState() {
      self.shortTripView().notificationLabel.text = "Entered Waiting For Trip to Start"
      self.shortTripView().currentStateLabel.text = "Waiting for Trip to Start"
      self.shortTripView().notificationImageView.image = UIImage(named: "unknownAirline.png")
    }
  }
}