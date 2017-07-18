//
//  DispatcherClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/23/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias ConeClosure = (Cone?) -> Void

extension ApiClient {
  static func fetchCone(_ completion: @escaping ConeClosure) {
    Alamofire.request(Url.Taxi.Dispatcher.cone, headers: headers())
      .responseObject { (dataResponse: DataResponse<Cone>) in
        if let raw = dataResponse.response {
          NotificationCenter.default.post(name: .response, object: nil, userInfo: [InfoKey.response: raw])
        }
        completion(dataResponse.result.value)
    }
  }
}
