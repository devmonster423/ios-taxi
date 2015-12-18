//
//  ShortTripGeofence.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/17/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper

var allGeofences = [
  domesticPickupGeofence,
  entryGateGeofence,
  intlPickupGeofence,
  sfoGeofence,
  taxiMergedGeofence,
  terminalExitGeofence,
  validCitiesGeofence
]

var domesticPickupGeofence = LocalGeofence("Domestic_Pax_Pickup")
var entryGateGeofence = LocalGeofence("Entry_Gate")
var intlPickupGeofence = LocalGeofence("International_Pax_Pickup")
var sfoGeofence = LocalGeofence("SFO")
var taxiMergedGeofence = LocalGeofence("taxi_sfo_merged")
var terminalExitGeofence = LocalGeofence("Terminal_Exit")
var validCitiesGeofence = LocalGeofence("Valid_Cities")
