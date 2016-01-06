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
    if state == NotReady.sharedInstance.getState()
      || state == WaitingForEntryCid.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()
      || state == WaitingForEntryAvi.sharedInstance.getState()
      || state == WaitingInHoldingLot.sharedInstance.getState()
      || state == WaitingForPaymentCid.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState()
      || state == WaitingForTaxiLoopAvi.sharedInstance.getState() {
        
        self.shortTripView().currentStateLabel.text = NSLocalizedString("Not Ready", comment: "")
        self.shortTripView().notify(NSLocalizedString("In Not Ready State", comment: ""))
        if TripManager.sharedInstance.mostRecentTripWasValid() {
          self.shortTripView().topImageView.image = Image.tripCheck.image()
          self.shortTripView().notificationImageView.image = Image.taxicheckmark.image()
        } else {
          self.shortTripView().topImageView.image = Image.tripHorizontalDivider.image()
          self.shortTripView().notificationImageView.image = Image.thumbsdown.image()
        }
      
    } else if state == Ready.sharedInstance.getState()
      || state == WaitingForExitAvi.sharedInstance.getState()
      || state == WaitingForStartTrip.sharedInstance.getState() {
        
        self.shortTripView().currentStateLabel.text = NSLocalizedString("Ready", comment: "")
        self.shortTripView().notify(NSLocalizedString("In Ready State", comment: ""))
        self.shortTripView().notificationImageView.image = Image.thumbsup.image()
      
    } else if state == InProgress.sharedInstance.getState()
      || state == WaitingForReEntryAvi.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState()
      || state == WaitingForReEntryCid.sharedInstance.getState() {
        
        self.shortTripView().currentStateLabel.text = NSLocalizedString("Trip In Progress", comment: "")
        self.shortTripView().notify(NSLocalizedString("Trip In Progress", comment: ""))
        self.shortTripView().notificationImageView.image = Image.taxicab.image()
      
    } else if state == ValidatingTrip.sharedInstance.getState() {
      self.shortTripView().currentStateLabel.text = NSLocalizedString("Validating Trip", comment: "")
      self.shortTripView().notify(NSLocalizedString("Validating Trip", comment: ""))
      self.shortTripView().notificationImageView.image = Image.sfoTime.image()
    }
  }
}
