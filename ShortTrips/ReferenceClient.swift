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

typealias DoubleResponse = (Double?) -> Void
typealias IntResponse = (Int?) -> Void
typealias ReferenceConfigClosure = (ReferenceConfig?, Error?) -> Void
typealias StringClosure = (String?) -> Void

extension ApiClient {
  static func requestReferenceConfig(_ response: @escaping ReferenceConfigClosure) {
    authedRequest(.GET, Url.Reference.config)
      .responseObject { (referenceConfig: ReferenceConfig?, error: Error?) in
      response(referenceConfig, error)
    }
  }
  
  static func requestLotCapacity(_ response: @escaping IntResponse) {
    authedRequest(.GET, Url.Reference.lotCapacity)
      .responseString { _, _, resultString in
        if let string = resultString.value {
          response(Int(string))
        } else {
          response(nil)
        }
    }
  }
  
  static func requestVersion(_ response: @escaping DoubleResponse) {
    authedRequest(.GET, Url.Reference.clientVersion, parameters: ["platform":"ios"])
      .responseString { _, _, resultString in
        if let string = resultString.value {
          response(Double(string))
        } else {
          response(nil)
        }
    }
  }
  
  static func requestTermsAndConditions(_ response: @escaping StringClosure) {
    authedRequest(.GET, Url.Reference.terms)
      .responseString { _, _, resultString in
        response(resultString.value)
    }
  }
}
