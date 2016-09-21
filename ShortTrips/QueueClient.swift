//
//  QueueClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/13/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

typealias QueueLengthResponse = (QueueLength?) -> Void
typealias QueueLengthAndCapacityResponse = ((length: Int, capacity: Int)?) -> Void

extension ApiClient {
  static func requestQueueLength(_ response: @escaping QueueLengthResponse) {
    authedRequest(.GET, Url.Queue.currentLength)
      .responseObject { (referenceConfig: QueueLength?, _) in
        response(referenceConfig)
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
