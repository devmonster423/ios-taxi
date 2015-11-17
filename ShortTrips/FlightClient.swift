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

typealias FlightDetailsClosure = ([Flight]?, Int?) -> Void
typealias TerminalSummaryClosure = ([TerminalSummary]?, Int?, Int?) -> Void

protocol FlightClient { }

extension ApiClient {
  private static let noData = 3840
  
  static func requestFlightsForTerminal(terminal: Int, hour: Int, flightType: FlightType, response: FlightDetailsClosure) {
    let params = ["terminal_id": terminal, "hour": hour]
    let url = flightType == .Arrivals ? Url.Flight.Arrival.details : Url.Flight.Departure.details
    authedRequest(Alamofire.request(.GET, url, parameters: params))
      .responseObject { (request, urlResponse, flightDetailsWrapper: FlightDetailsWrapper?, _, error: ErrorType?) in
        response(flightDetailsWrapper?.flightDetails, urlResponse?.statusCode)
        if Util.debug {
          ErrorLogger.log(request, error: error)
        }
      }
  }
  
  static func requestTerminalSummaries(hour: Int, flightType: FlightType, response: TerminalSummaryClosure) {
    let params = ["hour": hour]
    switch flightType {
    case .Arrivals:
      authedRequest(Alamofire.request(.GET, Url.Flight.Arrival.summary, parameters: params))
        .responseObject { (request, urlResponse, terminalSummaryArrivalsWrapper: TerminalSummaryArrivalsWrapper?, _, error: ErrorType?) in
          response(terminalSummaryArrivalsWrapper?.terminalSummaries, hour, urlResponse?.statusCode)
          if Util.debug {
            ErrorLogger.log(request, error: error)
          }
      }
    case .Departures:
      authedRequest(Alamofire.request(.GET, Url.Flight.Departure.summary, parameters: params))
        .responseObject { (request, urlResponse, terminalSummaryDeparturesWrapper: TerminalSummaryDeparturesWrapper?, _, error: ErrorType?) in
          response(terminalSummaryDeparturesWrapper?.terminalSummaries, hour, urlResponse?.statusCode)
          if Util.debug {
            ErrorLogger.log(request, error: error)
          }
      }
    }
  }
}
