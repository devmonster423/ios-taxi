//
//  TripManager.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import TransitionKit

class TripManager {
  
  static let sharedInstance = TripManager()
  
  private var machine: TKStateMachine!
  var startTime: NSDate?
  private var tripId: Int?
  private var warnings = [TripWarning]()
  private var tripTimer: NSTimer?
  private static let timerInterval: NSTimeInterval = 5.0
  private static let tripLengthLimit: NSTimeInterval = 7200.0
  
  static let allStates = [
    AssociatingDriverAndVehicle.sharedInstance.getState(),
    InProgress.sharedInstance.getState(),
    NotReady.sharedInstance.getState(),
    Ready.sharedInstance.getState(),
    Valid.sharedInstance.getState(),
    ValidatingTrip.sharedInstance.getState(),
    VerifyingEntryGateAVI.sharedInstance.getState(),
    VerifyingExitAvi.sharedInstance.getState(),
    VerifyingTaxiLoopAVI.sharedInstance.getState(),
    WaitingForEntryCID.sharedInstance.getState(),
    WaitingForPaymentCID.sharedInstance.getState(),
    WaitingForStartTrip.sharedInstance.getState(),
    WaitingInHoldingLot.sharedInstance.getState()
  ]
  
  static func allEvents() -> [TKEvent] {
    var events = DriverAndVehicleAssociated.sharedInstance.getEvents()
    events += DriverProceedsToTaxiLoop.sharedInstance.getEvents()
    events += EntryGateAVIReadConfirmed.sharedInstance.getEvents()
    events += ExitAviReadFailed.sharedInstance.getEvents()
    events += Failure.sharedInstance.getEvents()
    events += InsideSfo.sharedInstance.getEvents()
    events += InsideTaxiLoopExit.sharedInstance.getEvents()
    events += LatestAviReadAtExit.sharedInstance.getEvents()
    events += LatestAviReadAtTaxiLoop.sharedInstance.getEvents()
    events += LatestCidIsEntryCid.sharedInstance.getEvents()
    events += LatestCidIsPaymentCid.sharedInstance.getEvents()
    events += OutsideSfo.sharedInstance.getEvents()
    events += TripStarted.sharedInstance.getEvents()
    events += TimeExpired.sharedInstance.getEvents()
    events += TripValidated.sharedInstance.getEvents()
    return events
  }
  
  private init() {
    setup()
  }

  func setup() {
    machine = TKStateMachine()
    machine.addStates(TripManager.allStates)
    machine.initialState = NotReady.sharedInstance.getState()
    machine.addEvents(TripManager.allEvents())
    machine.activate()
    LocationManager.sharedInstance.start()
    GeofenceManager.sharedInstance.start()
    if let tripTimer = tripTimer {
      tripTimer.invalidate()
    }
    weak var weakSelf = self
    tripTimer = NSTimer.scheduledTimerWithTimeInterval(TripManager.timerInterval,
      target: weakSelf!,
      selector: "checkLength",
      userInfo: nil,
      repeats: true)
    startTime = NSDate()
  }
  
  @objc func checkLength() {
    if getElapsedTime() > TripManager.tripLengthLimit {
      TimeExpired.sharedInstance.fire()
      tripTimer?.invalidate()
    }
  }
  
  func getMachine() -> TKStateMachine {
    return machine
  }
  
  func getTripId() -> Int? {
    return tripId
  }
  
  func setTripId(tripId: Int) {
    self.tripId = tripId
  }
  
  func setStartTime(time: NSDate) {
    self.startTime = time
  }
  
  func getElapsedTime() -> NSTimeInterval? {
    if let interval = startTime?.timeIntervalSinceNow {
      return -interval
    } else {
      return nil
    }
  }
  
  func addWarning(warning: TripWarning) {
    warnings.append(warning)
  }
  
  func getWarnings() -> [TripWarning] {
    return warnings
  }
  
  func stopTimer() {
    tripTimer?.invalidate()
  }
}
