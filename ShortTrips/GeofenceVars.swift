//
//  ShortTripGeofence.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

let allGeofences = [
  domesticPickupGeofence,
  taxiMergedGeofence,
  taxiWaitingZone,
  terminalExitBufferedGeofence
]

let domesticPickupGeofence = LocalGeofence(jsonFileName: "Domestic_Pax_Pickup", sfoGeofence: .sfoTaxiDomesticExit)
let taxiMergedGeofence = LocalGeofence(jsonFileName: "taxi_sfo_merged", sfoGeofence: .taxiSfoMerged)
let taxiWaitingZone = LocalGeofence(jsonFileName: "Taxi_Waiting_Zone", sfoGeofence: .taxiWaitingZone)
let terminalExitBufferedGeofence = LocalGeofence(jsonFileName: "Terminal_exit_buffered", sfoGeofence: .taxiExitBuffered)
