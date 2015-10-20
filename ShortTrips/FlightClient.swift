//
//  FlightClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias FlightsForTerminalClosure = ([Flight]?, NSHTTPURLResponse?, ErrorType?) -> Void
typealias TerminalSummaryClosure = ([TerminalSummary]?, Int?, NSHTTPURLResponse?, ErrorType?) -> Void

protocol FlightClient { }

extension ApiClient {
  private static let noData = 3840
  
  static func requestFlightsForTerminal(terminal: Int, hour: Int, response: FlightsForTerminalClosure) {
    let params = ["terminal_id": terminal, "hour": hour]
    authedRequest(Alamofire.request(.GET, Url.Flight.Arrival.details, parameters: params))
      .responseObject { (request, urlResponse, flightsForTerminalResponse: FlightsForTerminalResponse?, _, error: ErrorType?) in
      if error != nil && (error as! NSError).code != noData {
        if Util.debug {
          ErrorLogger.log(request, error: error)
        }
      }
      else {
        response(flightsForTerminalResponse?.flightDetailResponse?.flightDetails, urlResponse, error)
      }
    }
  }
  
  static func requestTerminalSummary(hour: Int, response: TerminalSummaryClosure) {
    let params = ["hour": hour]
    authedRequest(Alamofire.request(.GET, Url.Flight.Arrival.summary, parameters: params))
      .responseObject { (request, urlResponse, terminalSummaryResponse: TerminalSummaryResponse?, _, error: ErrorType?) in
      if error != nil {
        if Util.debug {
          ErrorLogger.log(request, error: error)
        }
      }
      else {
        response(terminalSummaryResponse?.terminalSummaryArrivalsResponse?.terminalSummaryArrivalsListResponse?.terminalSummaryArrivalsList, hour, urlResponse, error)
      }
    }
  }
}
