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

typealias FlightsForTerminalClosure = ([Flight]?, Int?) -> Void
typealias TerminalSummaryClosure = ([TerminalSummary]?, Int?, Int?) -> Void

protocol FlightClient { }

extension ApiClient {
  private static let noData = 3840
  
  static func requestFlightsForTerminal(terminal: Int, hour: Int, flightType: FlightType, response: FlightsForTerminalClosure) {
    let params = ["terminal_id": terminal, "hour": hour]
    let url = flightType == .Arrivals ? Url.Flight.Arrival.details : Url.Flight.Departure.details
    print("url: \(url)")
    authedRequest(Alamofire.request(.GET, url, parameters: params))
      .responseObject { (request, urlResponse, flightsForTerminalResponse: FlightsForTerminalResponse?, _, error: ErrorType?) in
        response(flightsForTerminalResponse?.flightDetailResponse?.flightDetails, urlResponse?.statusCode)
        if Util.debug {
          ErrorLogger.log(request, error: error)
        }
      }
  }
  
  static func requestTerminalSummary(hour: Int, flightType: FlightType, response: TerminalSummaryClosure) {
    let params = ["hour": hour]
    switch flightType {
    case .Arrivals:
      authedRequest(Alamofire.request(.GET, Url.Flight.Arrival.summary, parameters: params))
        .responseObject { (request, urlResponse, terminalSummaryAResponse: TerminalSummaryAResponse?, _, error: ErrorType?) in
          response(terminalSummaryAResponse?.terminalSummaryArrivalsResponse?.terminalSummaryListResponse?.terminalSummaryList, hour, urlResponse?.statusCode)
          if Util.debug {
            ErrorLogger.log(request, error: error)
          }
      }
    case .Departures:
      authedRequest(Alamofire.request(.GET, Url.Flight.Departure.summary, parameters: params))
        .responseObject { (request, urlResponse, terminalSummaryDResponse: TerminalSummaryDResponse?, _, error: ErrorType?) in
          response(terminalSummaryDResponse?.terminalSummaryDeparturesResponse?.terminalSummaryListResponse?.terminalSummaryList, hour, urlResponse?.statusCode)
          if Util.debug {
            ErrorLogger.log(request, error: error)
          }
      }
    }
  }
}
