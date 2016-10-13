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

extension ApiClient {
  fileprivate static let noData = 3840
  
  static func requestFlightsForTerminal(_ terminal: Int, hour: Int, flightType: FlightType, response: @escaping FlightDetailsClosure) {
    let params = ["terminal_id": terminal, "hour": hour]
    let url = flightType == .Arrivals ? Url.Flight.Arrival.details : Url.Flight.Departure.details
    
    Alamofire.request(url, parameters: params, headers: headers())
      .responseObject { (dataResponse: DataResponse<FlightDetailsWrapper>) in
        response(dataResponse.result.value?.flightDetails, dataResponse.response?.statusCode)
        if Util.debug {
          ErrorLogger.log(dataResponse.request, error: dataResponse.result.error)
        }
      }
  }
  
  static func requestTerminalSummaries(_ hour: Int, flightType: FlightType, response: @escaping TerminalSummaryClosure) {
    let params = ["hour": hour]
    switch flightType {
      
    case .Arrivals:
      Alamofire.request(Url.Flight.Arrival.summary, parameters: params, headers: headers())
        .responseObject { (dataResponse: DataResponse<TerminalSummaryArrivalsWrapper>) in
          response(dataResponse.result.value?.terminalSummaries, hour, dataResponse.response?.statusCode)
          if Util.debug {
            ErrorLogger.log(dataResponse.request, error: dataResponse.result.error)
          }
      }
      
    case .Departures:
      Alamofire.request(Url.Flight.Departure.summary, parameters: params, headers: headers())
        .responseObject { (dataResponse: DataResponse<TerminalSummaryDeparturesWrapper>) in
          response(dataResponse.result.value?.terminalSummaries, hour, dataResponse.response?.statusCode)
          if Util.debug {
            ErrorLogger.log(dataResponse.request, error: dataResponse.result.error)
          }
      }
    }
  }
}
