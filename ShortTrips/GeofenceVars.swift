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

let domesticPickupGeofence = LocalGeofence(jsonFileName: "Domestic_Pax_Pickup", sfoGeofence: .SfoTaxiDomesticExit)
let entryGateGeofence = LocalGeofence(jsonFileName: "Entry_Gate", sfoGeofence: .SfoTaxiEntryGate)
let intlPickupGeofence = LocalGeofence(jsonFileName: "International_Pax_Pickup", sfoGeofence: .SfoInternationalExit)
let sfoGeofence = LocalGeofence(jsonFileName: "SFO", sfoGeofence: .Sfo)
let taxiMergedGeofence = LocalGeofence(jsonFileName: "taxi_sfo_merged", sfoGeofence: .TaxiSfoMerged)
let taxiWaitingZone = LocalGeofence(jsonFileName: "Taxi_Waiting_Zone", sfoGeofence: .TaxiWaitingZone)
let terminalExitGeofence = LocalGeofence(jsonFileName: "Terminal_Exit", sfoGeofence: .SfoTerminalExit)
let validCitiesGeofence = LocalGeofence(jsonFileName: "Valid_Cities", sfoGeofence: .TaxiSfoMerged)
