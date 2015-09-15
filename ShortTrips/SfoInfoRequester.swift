//
//  SfoInfoRequester.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias LotStatusResponseClosure = (LotStatusResponse?, NSError?) -> Void
typealias TerminalResponseClosure = ([TerminalSummary]?, NSError?) -> Void
typealias FlightResponseClosure = ([Flight]?, NSError?) -> Void
typealias GeofencesResponseClosure = ([Geofence]?, NSError?) -> Void

// /taxi/flight/summary
// Endpoint URL: http://localhost:8181/taxiws/services/taxi/flight/summary
// Example: GET http://localhost:8181/taxiws/services/taxi/flight/summary?(hour)

// /taxi/flight/arrival/details
// Endpoint URL: http://localhost:8080/taxiws/services/taxi/flight/arrival/details
// Example: GET http://localhost:8080/taxiws/services/taxi/flight/arrival/details?terminal_id=1&hour=1


class SfoInfoRequester {
  private static let baseUrl = "https://216.9.96.29:9000/taxiws/services/taxi/"
  private static let lotStatusUrl = "lot_status"
  private static let terminalUrl = "flight/summary"
  private static let flightUrl = "flight/arrival/details"
  private static let geofenceUrl = "geofence"
  private static let locationUrl = "location"

  class func requestLotStatus(response: LotStatusResponseClosure) {
    Alamofire.request(.GET, baseUrl + lotStatusUrl, parameters: nil).responseObject(response)
  }
  
  class func requestTerminals(hour: Int, response: TerminalResponseClosure) {
    let params = ["hour": hour]
    Alamofire.request(.GET, baseUrl + terminalUrl, parameters: params).responseArray(response)
  }
  
  class func requestFlights(terminal: Int, hour: Int, response: FlightResponseClosure) {
    let params = ["terminal_id": terminal, "hour" : hour]
    Alamofire.request(.GET, baseUrl + flightUrl, parameters: params).responseArray(response)
  }
  
  class func requestAllGeofences(response: GeofencesResponseClosure) {
    Alamofire.request(.GET, baseUrl + geofenceUrl, parameters: nil).responseArray(response)
  }
  
  class func requestGeofenceForLocation(longitude: Float, latitude: Float, buffer: Float, response: GeofencesResponseClosure) {
    let params = ["longitude": longitude, "latitude": latitude, "buffer": buffer]
    Alamofire.request(.GET, baseUrl + geofenceUrl + "/" + locationUrl, parameters: params).responseArray(response)
  }
  
  class func requestGeofenceForId(id: Int, response: GeofencesResponseClosure) {
    Alamofire.request(.GET, baseUrl + geofenceUrl + "/" + "\(id)", parameters: nil).responseArray(response)
  }
}
