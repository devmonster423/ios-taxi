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
        
        self.shortTripView().updateTitle(.NotReady)
        if TripManager.sharedInstance.mostRecentTripWasValid() {
          self.shortTripView().topImageView.image = Image.tripCheck.image()
          self.shortTripView().notificationImageView.image = Image.tripCar.image()
        } else {
          self.shortTripView().topImageView.image = Image.tripHorizontalDivider.image()
          self.shortTripView().notificationImageView.image = Image.tripAlert.image()
        }
        
        if state == NotReady.sharedInstance.getState()
          || state == WaitingForEntryCid.sharedInstance.getState()
          || state == AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()
          || state == WaitingForEntryAvi.sharedInstance.getState() {
            
            self.shortTripView().notify(NSLocalizedString("Not In Holding Lot", comment: ""))
        } else {
          self.shortTripView().notify(NSLocalizedString("In Holding Lot", comment: ""))
        }
      
    } else if state == Ready.sharedInstance.getState()
      || state == WaitingForExitAvi.sharedInstance.getState()
      || state == WaitingForStartTrip.sharedInstance.getState() {
        
        self.shortTripView().topImageView.image = Image.tripHorizontalDivider.image()
        self.shortTripView().updateTitle(.Ready)
        self.shortTripView().notify("")
        self.shortTripView().notificationImageView.image = Image.tripThumbsUp.image()
      
    } else if state == InProgress.sharedInstance.getState()
      || state == WaitingForReEntryAvi.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState()
      || state == WaitingForReEntryCid.sharedInstance.getState() {
        
        self.shortTripView().topImageView.image = Image.tripHorizontalDivider.image()
        self.shortTripView().updateTitle(.InProgress)
        self.shortTripView().notify("")
        self.shortTripView().notificationImageView.image = Image.tripCarInProgress.image()
      
    } else if state == ValidatingTrip.sharedInstance.getState() {
      self.shortTripView().topImageView.image = Image.tripHorizontalDivider.image()
      self.shortTripView().updateTitle(.Validating)
      self.shortTripView().notify("")
      self.shortTripView().notificationImageView.image = Image.tripCarInProgress.image()
    }
  }
}
