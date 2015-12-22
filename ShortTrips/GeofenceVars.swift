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
  entryGateGeofence,
  intlPickupGeofence,
  sfoGeofence,
  taxiMergedGeofence,
  taxiWaitingZone,
  terminalExitGeofence,
  validCitiesGeofence
]

let domesticPickupGeofence = LocalGeofence("Domestic_Pax_Pickup")
let entryGateGeofence = LocalGeofence("Entry_Gate")
let intlPickupGeofence = LocalGeofence("International_Pax_Pickup")
let sfoGeofence = LocalGeofence("SFO")
let taxiMergedGeofence = LocalGeofence("taxi_sfo_merged")
let taxiWaitingZone = LocalGeofence("Taxi_Waiting_Zone")
let terminalExitGeofence = LocalGeofence("Terminal_Exit")
let validCitiesGeofence = LocalGeofence("Valid_Cities")
