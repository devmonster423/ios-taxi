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

// /taxi/flight/summary
// Endpoint URL: http://localhost:8181/taxiws/services/taxi/flight/summary
// Example: GET http://localhost:8181/taxiws/services/taxi/flight/summary?(hour)

// /taxi/flight/arrival/details
// Endpoint URL: http://localhost:8080/taxiws/services/taxi/flight/arrival/details
// Example: GET http://localhost:8080/taxiws/services/taxi/flight/arrival/details?terminal_id=1&hour=1


class SfoInfoRequester {
  private static let baseUrl = "http://localhost:8181/taxiws/services/taxi/"
  private static let lotStatusUrl = "lot_status"
  private static let terminalUrl = "flight/summary"
  private static let flightUrl = "flight/arrival/details"

  class func requestLotStatus(response: LotStatusResponseClosure) {
    Alamofire.request(.GET, baseUrl + lotStatusUrl, parameters: nil).responseObject(response)
  }
  
  class func requestTerminals(response: TerminalResponseClosure, hour: Int) {
    let params = ["hour": hour]
    Alamofire.request(.GET, baseUrl + terminalUrl, parameters: params).responseArray(response)
  }
  
  class func requestFlights(response: FlightResponseClosure, terminal: Int, hour: Int) {
    let params: [String: String] = ["terminal_id": "\(terminal)", "hour" : "\(hour)"]
    Alamofire.request(.GET, baseUrl + flightUrl, parameters: params).responseArray(response)
  }
}
