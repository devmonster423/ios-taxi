//
//  StateShortTrip.swift
//  ShortTrips
//
//  Created by Joshua Adams on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import TransitionKit

extension ShortTripVC {
  
  func notifyFail(_ validationStep: ValidationStep) {
    if let _ = TripManager.sharedInstance.getTripId() {
      self.shortTripView().notifyFail(validationStep)
    }
  }
  
  func setupObservers() {
    
    let nc = NotificationCenter.default

    nc.addObserver(forName: .tripInvalidated, object: nil, queue: nil) { note in
      if let validationSteps = note.userInfo?[InfoKey.validationSteps] as? [ValidationStepWrapper], validationSteps.count > 0 {
        
        self.notifyFail(validationSteps.first!.validationStep)
      } else {
        self.notifyFail(.unspecified)
      }
    }
    
    nc.addObserver(forName: .locStatusUpdated, object: nil, queue: nil) { note in
      let status = note.userInfo![InfoKey.locationStatus] as! CLAuthorizationStatus
      if status != .authorizedAlways {
        self.notifyFail(.gpsFailure)
      }
    }
    
    nc.addObserver(forName: .logout, object: nil, queue: nil) { note in
      self.notifyFail(.userLogout)
      self.shortTripView().hideNotification()
    }
    
    nc.addObserver(forName: .reachabilityChanged, object: nil, queue: nil) { note in
      let reachable = note.userInfo![InfoKey.reachable] as! Bool
      self.shortTripView().setReachabilityNoticeHidden(reachable)
    }
    
    nc.addObserver(forName: .stateUpdate, object: nil, queue: nil) { note in
      let state = note.userInfo![InfoKey.state] as! TKState
      self.updateForState(state)
    }
    
    nc.addObserver(forName: .outsideShortTrip, object: nil, queue: nil) { note in
      self.notifyFail(.geofence)
    }
    
    nc.addObserver(forName: .timeExpired, object: nil, queue: nil) { note in
      self.notifyFail(.duration)
    }
    
    nc.addObserver(forName: .tripValidated, object: nil, queue: nil) { note in
      let date = note.userInfo![InfoKey.date] as! Date
      self.shortTripView().notifySuccess(date)
    }
    
    nc.addObserver(forName: .pushReceived, object: nil, queue: nil) { note in
      if let active = note.userInfo![InfoKey.appActive] as? Bool,
        active,
        self.tabBarController?.selectedIndex == MainTabs.trip.rawValue,
        self.navigationController?.visibleViewController == self {
        
        if let title = note.userInfo![InfoKey.pushText] as? String {
          self.hideAndShowAlert(title)
        } else if let message = note.userInfo![InfoKey.pushText] as? [String: String] {
          self.hideAndShowAlert(message["title"], message["body"])
        }
      } else {
        self.tabBarController?.selectedIndex = MainTabs.lot.rawValue
      }
    }
  }
  
  func initializeForState(_ state: TKState) {
    
    if state == GpsIsOff.sharedInstance.getState()
      || state == NotReady.sharedInstance.getState()
      || state == WaitingInHoldingLot.sharedInstance.getState()
      || state == Ready.sharedInstance.getState()
      || state == InProgress.sharedInstance.getState() {
        
        updateForState(state)
        
    } else if state == WaitingForExitAvi.sharedInstance.getState() {
      updateForState(Ready.sharedInstance.getState())
        
    } else if tripInProgress(state) {
      updateForState(InProgress.sharedInstance.getState())
      
    } else {
      updateForState(NotReady.sharedInstance.getState())
    }
  }
  
  func updateForState(_ state: TKState) {
    
    if state == GpsIsOff.sharedInstance.getState() {
      
      self.shortTripView().updatePrompt(.turnOnGps)
      
    } else if state == NotReady.sharedInstance.getState() {
        
      self.shortTripView().updatePrompt(.goToSfo)
      
    } else if state == WaitingInHoldingLot.sharedInstance.getState() {
        
      self.shortTripView().updatePrompt(.pay)
      
    } else if state == Ready.sharedInstance.getState() {

      self.shortTripView().updatePrompt(.ready)
      self.shortTripView().hideNotification()
      
    } else if state == InProgress.sharedInstance.getState() {
      self.shortTripView().updatePrompt(.inProgress)
    }
    
    shortTripView().toggleCountdown(tripInProgress(state))
  }

  func tripInProgress(_ state: TKState) -> Bool {
    return state == InProgress.sharedInstance.getState()
      || state == WaitingForReEntryAvi.sharedInstance.getState()
      || state == AssociatingDriverAndVehicleAtReEntry.sharedInstance.getState()
      || state == WaitingForReEntryCid.sharedInstance.getState()
      || state == ValidatingTrip.sharedInstance.getState()
  }
}
