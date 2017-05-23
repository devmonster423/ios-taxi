//
//  CidDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import Crashlytics

extension DebugVC {
  
  // MARK: AVI
  func confirmEntryGateAviRead() {
    let antenna = Antenna(antennaId: "L27AVI1", aviLocation: "Location #27 Taxi Entry", aviDate: Date())
    AviManager.sharedInstance.setLatestAviLocation(antenna.device()!)
    LatestAviAtEntry.sharedInstance.fire(antenna)
  }
  
  func confirmReEntryGateAviRead() {
    let antenna = Antenna(antennaId: "L27AVI1", aviLocation: "Location #27 Taxi Entry", aviDate: Date())
    AviManager.sharedInstance.setLatestAviLocation(antenna.device()!)
    LatestAviAtReEntry.sharedInstance.fire(antenna)
  }
  
  func latestAviReadAtTaxiLoop() {
    let antenna = Antenna(antennaId: "L14AVI1", aviLocation: "Location #14 Taxi Loop", aviDate: Date())
    AviManager.sharedInstance.setLatestAviLocation(antenna.device()!)
    LatestAviAtTaxiLoop.sharedInstance.fire(antenna)
  }
  
  func latestDomExitAviRead() {
    let antenna = Antenna(antennaId: "L2AVI1", aviLocation: "Location #2 Domestic Exit", aviDate: Date())
    AviManager.sharedInstance.setLatestAviLocation(antenna.device()!)
    ExitAviCheckComplete.sharedInstance.fire(antenna)
  }
  
  // MARK: CID
  func fakeCidPayment() {
    let cid = Cid(cidId: "456", cidLocation: "payment", cidTimeRead: Date())
    LatestCidIsPaymentCid.sharedInstance.fire(cid)
  }
  
  func triggerEntryCid() {
    let cid = Cid(cidId: "123", cidLocation: "entry", cidTimeRead: Date())
    LatestCidIsEntryCid.sharedInstance.fire(cid)
  }
  
  func triggerReEntryCid() {
    let cid = Cid(cidId: "123", cidLocation: "entry", cidTimeRead: Date())
    LatestCidIsReEntryCid.sharedInstance.fire(cid)
  }
  
  // MARK: DRIVER
  func associateDriverAndVehicle() {
    let vehicle = Vehicle(gtmsTripId: 10590,
                          licensePlate: "13702K1",
                          medallion: "0737",
                          transponderId: 2005887,
                          vehicleId: 12999)
    DriverManager.sharedInstance.setCurrentVehicle(vehicle)
  }
  
  // MARK: LOCATION
  func backToSFO() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.614695, longitude: -122.39468)])
  }
  
  func fakeGpsOn() {
    Util.testingGps = true
    GpsEnabled.sharedInstance.fire()
  }
  
  func dropPassenger() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.622254, longitude: -122.409925)])
    self.updateFakeButtons((title: "Back To SFO", action: #selector(DebugVC.backToSFO)),
                           second: (title: "Turn Off Pings", action: #selector(DebugVC.turnOffPings)),
                           third: (title: "Crash App", action: #selector(DebugVC.crash)))
  }
  
  func fakeExitingTerminals() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.615119, longitude: -122.393328)])
  }
  
  func fakeOutsideGeofences() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.760661, longitude: -122.434092)])
  }
  
  func crash() {
    if Util.debug {
      Crashlytics.sharedInstance().crash()
    }
  }
  
  func triggerOutsideDomesticTerminalExit() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.614319, longitude: -122.390206)])
  }
  
  func triggerAtIntlTerminal() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.6149, longitude: -122.39)])
  }
  
  func triggerAtTerminalExit() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.6168, longitude: -122.3843)])
  }
  
  func triggerInsideSfo() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.621313, longitude: -122.378955)])
  }
  
  func triggerInsideTaxiWaitingZone() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.616424, longitude: -122.386107)])
  }
  
  func triggerOutsideTaxiWaitingZone() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.621313, longitude: -122.378955)])
  }
  
  func triggerAtDomesticDropoff() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.615943, longitude: -122.384233)])
  }
  
  func inDomExit() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.616798, longitude: -122.384317)])
  }
  
  func inIntlExit() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.615149, longitude: -122.390133)])
  }
  
  func outOfBufferedExit() {
    Util.testingGps = true
    NotificationCenter.default.post(name: .locRead, object: nil, userInfo: [InfoKey.location: CLLocation(latitude: 37.616489, longitude: -122.398215)])
  }
  
  // MARK: PING
  func turnOffPings() {
    PingKiller.sharedInstance.turnOffPingsForAWhile()
    self.debugView().printDebugLine("pings will fail for 2 min", type: .negative)
  }
  
  // MARK: TIME
  func fakeTimeExpired() {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
      TimeExpired.sharedInstance.fire()
    }
  }
  
  // MARK: TRIP
  func generateTripId() {
    TripStarted.sharedInstance.fire(123)
  }
}
