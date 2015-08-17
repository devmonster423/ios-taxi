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
typealias TerminalResponseClosure = ([Terminal]?, NSError?) -> Void
typealias FlightResponseClosure = ([Flight]?, NSError?) -> Void

// /taxi/flight/summary
// Endpoint URL: http://localhost:8181/taxiws/services/taxi/flight/summary
// Example: GET http://localhost:8181/taxiws/services/taxi/flight/summary?(hour)

// /taxi/flight/arrival/details
// Endpoint URL: http://localhost:8080/taxiws/services/taxi/flight/arrival/details
// Example: GET http://localhost:8080/taxiws/services/taxi/flight/arrival/details?terminal_id=1&hour=1


class SfoInfoRequester {
  private class var baseUrl : String { return "http://localhost:8181/taxiws/services/taxi/" }
  private class var lotStatusUrl : String { return "lot_status" }
  private class var terminalUrl : String { return "flight/summary?(hour)" }
  private class var flightUrl : String { return "flight/arrival/details" }

  
  class func requestLotStatus(response: LotStatusResponseClosure) {
    println("requesting lot status: \(baseUrl + lotStatusUrl)")
    Alamofire.request(.GET, baseUrl + lotStatusUrl, parameters: nil).responseObject(response)
  }
  
  class func requestTerminals(response: TerminalResponseClosure) {
    println("requesting terminals: \(baseUrl + terminalUrl)")
    Alamofire.request(.GET, baseUrl + terminalUrl, parameters: nil).responseArray(response)
  }
  
  // TODO: parameterize terminal
  class func requestFlights(response: FlightResponseClosure) {
    println("requesting flights: \(baseUrl + flightUrl)?terminal_id=1&hour=1")
    Alamofire.request(.GET, baseUrl + flightUrl + "?terminal_id=" + "1" + "&hour=1", parameters: nil).responseArray(response)
  }
}
