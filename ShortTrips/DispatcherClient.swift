//
//  DispatcherClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias LotStatusClosure = (LotStatus?, NSHTTPURLResponse?, ErrorType?) -> Void

protocol DispatcherClient { }

extension ApiClient {
  static func requestLotStatus(response: LotStatusClosure) {
    authedRequest(Alamofire.request(.GET, Url.Dispatcher.holdingLotCapacity, parameters: nil))
      .responseObject { (request, urlResponse, statusResponse: LotStatusResponse?, _, error: ErrorType?) in
      if error != nil {
        if Util.debug {
          ErrorLogger.log(request, error: error)
        }
      }
      else {
        response(statusResponse?.lotStatus, urlResponse, error)
      }
    }
  }
}