//
//  FlightRequester.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias FlightsForTerminalClosure = ([Flight]?) -> Void
typealias TerminalSummaryClosure = ([TerminalSummary]?, Int?, ErrorType?) -> Void

protocol FlightClient { }

extension ApiClient {
  static func requestFlightsForTerminal(terminal: Int, hour: Int, response: FlightsForTerminalClosure) {
    let params = ["terminal_id": terminal, "hour": hour]
    authedRequest(Alamofire.request(.GET, Url.Flight.Arrival.details, parameters: params))
      .responseObject { (request, _, flightsForTerminalResponse: FlightsForTerminalResponse?, _, error: ErrorType?) in
        
        ErrorLogger.log(request, error: error)
        response(flightsForTerminalResponse?.flightDetailResponse?.flightDetails)
    }
  }
  
  static func requestTerminalSummary(hour: Int, response: TerminalSummaryClosure) {
    let params = ["hour": hour]
    authedRequest(Alamofire.request(.GET, Url.Flight.Arrival.summary, parameters: params))
      .responseObject { (terminalSummaryResponse: TerminalSummaryResponse?, error: ErrorType?) in
        response(terminalSummaryResponse?.terminalSummaryArrivalsResponse?.terminalSummaryArrivalsListResponse?.terminalSummaryArrivalsList, hour, error)
    }
  }
}
