//
//  ReferenceClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

typealias ReferenceConfigClosure = (ReferenceConfig?, ErrorType?) -> Void

extension ApiClient {
  static func requestReferenceConfig(response: ReferenceConfigClosure) {
    authedRequest(.GET, Url.Reference.config, parameters: nil)
      .responseObject { (referenceConfig: ReferenceConfig?, error: ErrorType?) in
      response(referenceConfig, error)
    }
  }
}
