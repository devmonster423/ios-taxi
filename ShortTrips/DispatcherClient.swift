//
//  DispatcherClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

typealias LotStatusClosure = (LotStatus?, Int?) -> Void

protocol DispatcherClient { }

extension ApiClient {
  static func requestLotStatus(response: LotStatusClosure) {
    authedRequest(.GET, Url.Dispatcher.holdingLotCapacity)
      .responseObject { (request, urlResponse, lotStatus: LotStatus?, _, error: ErrorType?) in
        response(lotStatus, urlResponse?.statusCode)
        if Util.debug {
          ErrorLogger.log(request, error: error)
        }
    }
  }
}