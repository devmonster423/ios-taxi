//
//  AviDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import CoreLocation
import TransitionKit

extension DebugVC {
  func setupObservers() {
    
    let nc = NotificationCenter.default
    
    // MARK: AVI
    nc.addObserver(forName: .aviRead, object: nil, queue: nil) { note in
      let antenna = note.userInfo![InfoKey.antenna] as! Antenna
      self.debugView().updateAvi("\(antenna)")
      self.debugView().printDebugLine("avi read: (\(antenna)")
      self.debugView().incrementGtms()
    }
    
    nc.addObserver(forName: .aviUnexpected, object: nil, queue: nil) { note in
      let expected = note.userInfo![InfoKey.expectedGtmsLocation] as! GtmsLocation
      let found = note.userInfo![InfoKey.foundGtmsLocation] as! GtmsLocation
      self.debugView().printDebugLine("unexpected avi. expected \(expected.rawValue), found \(found.rawValue)", type: .negative)
      self.debugView().updateAvi("\(found.rawValue)")
      self.debugView().incrementGtms()
    }
    
    // MARK: CID
    nc.addObserver(forName: .cidRead, object: nil, queue: nil) { note in
      let cid = note.userInfo![InfoKey.cid] as! Cid
      self.debugView().updateCid("\(cid)")
      self.debugView().printDebugLine("cid read: \(cid)")
      self.debugView().incrementGtms()
    }
    
    nc.addObserver(forName: .cidUnexpected, object: nil, queue: nil) { note in
      let expected = note.userInfo![InfoKey.expectedGtmsLocation] as! GtmsLocation
      let found = note.userInfo![InfoKey.foundGtmsLocation] as! GtmsLocation
      self.debugView().printDebugLine("unexpected cid. expected \(expected.rawValue), found \(found.rawValue)", type: .negative)
      self.debugView().incrementGtms()
    }
    
    // MARK: DRIVER
    nc.addObserver(forName: .driverVehicleAssociated, object: nil, queue: nil) { note in
      let driver = note.userInfo![InfoKey.driver] as! Driver
      let vehicle = note.userInfo![InfoKey.vehicle] as! Vehicle
      self.debugView().printDebugLine("driver \(driver.firstName) \(driver.lastName) is associated with transponder: \(vehicle.transponderId)")
      self.debugView().incrementGtms()
    }
    
    // MARK: GEOFENCE
    nc.addObserver(forName: .foundInside, object: nil, queue: nil) { note in
      let geofences = note.userInfo![InfoKey.geofences] as! [SfoGeofence]
      self.debugView().updateGeofenceList(geofences)
    }
    
    nc.addObserver(forName: .outsideShortTrip, object: nil, queue: nil) { note in
      self.debugView().printDebugLine("Outside short trip geofence.", type: .negative)
    }
    
    // MARK: LOCATION
    nc.addObserver(forName: .locManagerStarted, object: nil, queue: nil) { note in
      self.debugView().printDebugLine("started location manager", type: .bigDeal)
    }
    
    nc.addObserver(forName: .locRead, object: nil, queue: nil) { note in
      let location = note.userInfo![InfoKey.location] as! CLLocation
      self.debugView().updateGPS(location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    nc.addObserver(forName: .locStatusUpdated, object: nil, queue: nil) { note in
      let status = note.userInfo![InfoKey.locationStatus] as! CLAuthorizationStatus
      if status == .authorizedAlways {
        self.debugView().printDebugLine("location status updated: GPS on")
      } else {
        self.debugView().printDebugLine("location status updated: GPS off!")
      }
    }
    
    // MARK: PING
    nc.addObserver(forName: .pingInvalid, object: nil, queue: nil) { note in
      let ping = note.userInfo![InfoKey.ping] as! Ping
      self.debugView().printDebugLine("invalid ping: (\(ping.latitude!), \(ping.longitude!)) at \(ping.timestamp!)", type: .negative)
    }
    
    nc.addObserver(forName: .pingValid, object: nil, queue: nil) { note in
      let ping = note.userInfo![InfoKey.ping] as! Ping
      self.debugView().printDebugLine("valid ping: (\(ping.latitude!), \(ping.longitude!)) at \(ping.timestamp!)")
    }
    
    // MARK: REACHABILITY
    nc.addObserver(forName: .reachabilityChanged, object: nil, queue: nil) { note in
      let reachable = note.userInfo![InfoKey.reachable] as! Bool
      self.debugView().setReachabilityNoticeHidden(reachable)
      if reachable {
        self.debugView().printDebugLine("network reachable", type: .positive)
      } else {
        self.debugView().printDebugLine("network unreachable", type: .negative)
      }
    }
    
    // MARK: RESPONSE
    nc.addObserver(forName: .response, object: nil, queue: nil) { note in
      let response = note.userInfo![InfoKey.response] as! HTTPURLResponse
      self.debugView().printDebugLine(
        "URL: \(response.url!)\nstatusCode: \(response.statusCode)", type: StatusCode.isSuccessful(response.statusCode) ? .positive : .negative
      )
    }
    
    // MARK: STATE
    nc.addObserver(forName: .stateUpdate, object: nil, queue: nil) { note in
      let state = note.userInfo![InfoKey.state] as! TKState
      self.updateForState(state)
    }
    
    // MARK: TRIP
    nc.addObserver(forName: .timeExpired, object: nil, queue: nil) { note in
      self.debugView().printDebugLine("Time Expired", type: .negative)
    }
    
    nc.addObserver(forName: .tripStarted, object: nil, queue: nil) { note in
      let tripId = note.userInfo![InfoKey.tripId] as! Int
      self.debugView().printDebugLine("Trip started: \(tripId)", type: .positive)
    }
    
    nc.addObserver(forName: .tripValidated, object: nil, queue: nil) { note in
      self.debugView().printDebugLine("Trip is valid", type: .positive)
    }
    
    nc.addObserver(forName: .tripInvalidated, object: nil, queue: nil) { note in
      if let validationSteps = note.userInfo?[InfoKey.validationSteps] as? [ValidationStepWrapper] {
        self.debugView().printDebugLine("Trip is invalid for reasons:", type: .negative)
        for validationStep in validationSteps {
          self.debugView().printDebugLine("\(validationStep.description)", type: .negative)
        }
      } else {
        self.debugView().printDebugLine("Trip is invalid", type: .negative)
      }
    }
    
    nc.addObserver(forName: .tripWarning, object: nil, queue: nil) { note in
      let warning = note.userInfo![InfoKey.warning] as! TripWarning
      self.debugView().printDebugLine("Trip Warning: \(warning.rawValue)")
    }
  }
}
