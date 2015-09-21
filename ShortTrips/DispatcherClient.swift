//
//  DispatcherRequester.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias LotStatusClosure = (LotStatus?, ErrorType?) -> Void

protocol DispatcherClient {
  static func requestLotStatus(response: LotStatusClosure)
}

extension ApiClient {
  static func requestLotStatus(response: LotStatusClosure) {
    Alamofire.request(.GET, Url.queueStatus, parameters: nil).responseObject { (statusResponse: LotStatusResponse?, error: ErrorType?) in
      response(statusResponse?.lotStatus, error)
    }
  }
}
