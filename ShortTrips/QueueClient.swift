//
//  QueueClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/13/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias QueueLengthResponse = (QueueLength?) -> Void
typealias QueueLengthAndCapacityResponse = ((length: Int, capacity: Int)?) -> Void

extension ApiClient {
  static func requestQueueLength(_ response: @escaping QueueLengthResponse) {
    Alamofire.request(Url.Queue.currentLength)
      .responseObject { (dataResponse: DataResponse<QueueLength>) in
        response(dataResponse.result.value)
    }
  }
  
  static func requestQueueLengthAndCapacity(_ response: @escaping QueueLengthAndCapacityResponse) {
    requestQueueLength { queueLength in
      if let length = queueLength?.longQueueLength {
        requestLotCapacity() { capacity in
          if let capacity = capacity {
            response((length: length, capacity: capacity))
          } else {
            response(nil)
          }
        }
      } else {
        response(nil)
      }
    }
  }
}
