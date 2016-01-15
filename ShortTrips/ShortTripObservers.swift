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
  
  func notifyFail(validationStep: ValidationStep) {
    if let _ = TripManager.sharedInstance.getTripId() {
      self.shortTripView().notifyFail(validationStep)
    }
  }
  
  func setupObservers() {
    
    sfoObservers.invalidatedObserver = NotificationObserver(notification: SfoNotification.Trip.invalidated) { validationSteps, _ in
      if let validationSteps = validationSteps where validationSteps.count > 0 {
        self.notifyFail(validationSteps.first!.validationStep)
      } else {
        self.notifyFail(.Unspecified)
      }
    }
    
    sfoObservers.locationStatusObserver = NotificationObserver(notification: SfoNotification.Location.statusUpdated) { status, _ in
      if status != .AuthorizedAlways {
        self.notifyFail(.GpsFailure)
      }
    }
    
    sfoObservers.logoutObserver = NotificationObserver(notification: SfoNotification.Driver.logout) { _, _ in
      self.notifyFail(.UserLogout)
    }
    
    sfoObservers.stateUpdateObserver = NotificationObserver(notification: SfoNotification.State.update) { state, _ in
      self.updateForState(state)
    }
    
    sfoObservers.outsideShortTripObserver = NotificationObserver(notification: SfoNotification.Geofence.outsideShortTrip) { _, _ in
      self.notifyFail(.Geofence)
    }
    
    sfoObservers.timeExpiredObserver = NotificationObserver(notification: SfoNotification.Trip.timeExpired) { _, _ in
      self.notifyFail(.Duration)
    }
    
    sfoObservers.validatedObserver = NotificationObserver(notification: SfoNotification.Trip.validated) { _, _ in
      self.shortTripView().notifySuccess()
    }
  }
  
  func updateForState(state: TKState) {
    
    if state == NotReady.sharedInstance.getState()
      || state == WaitingForEntryCid.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtEntry.sharedInstance.getState()
      || state == WaitingForEntryAvi.sharedInstance.getState() {
        
        self.shortTripView().updatePrompt(.GoToSfo)
      
    } else if state == WaitingInHoldingLot.sharedInstance.getState()
      || state == WaitingForPaymentCid.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtHoldingLotExit.sharedInstance.getState()
      || state == WaitingForTaxiLoopAvi.sharedInstance.getState() {
        
        self.shortTripView().updatePrompt(.Pay)
      
    } else if state == Ready.sharedInstance.getState()
      || state == WaitingForExitAvi.sharedInstance.getState()
      || state == WaitingForDomesticReEntryAvi.sharedInstance.getState()
      || state == WaitingForStartTrip.sharedInstance.getState() {
        
        self.shortTripView().updatePrompt(.Ready)
        self.shortTripView().hideNotification()
      
    } else if tripInProgress(state) {
        self.shortTripView().updatePrompt(.InProgress)
    }
    
    shortTripView().countdown.hidden = !tripInProgress(state)
  }

  func tripInProgress(state: TKState) -> Bool {
    return state == InProgress.sharedInstance.getState()
      || state == WaitingForReEntryAvi.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState()
      || state == WaitingForReEntryCid.sharedInstance.getState()
      || state == ValidatingTrip.sharedInstance.getState()
  }
}
