//
//  ReferenceClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias DoubleResponse = (Double?) -> Void
typealias IntResponse = (Int?) -> Void
typealias ReferenceConfigClosure = (ReferenceConfig?, Error?) -> Void
typealias StringClosure = (String?) -> Void

extension ApiClient {
  static func requestReferenceConfig(_ response: @escaping ReferenceConfigClosure) {
    Alamofire.request(Url.Taxi.Reference.config, headers: headers())
      .responseObject { (dataResponse: DataResponse<ReferenceConfig>) in
      response(dataResponse.result.value, dataResponse.result.error)
    }
  }
  
  static func requestLotCapacity(_ response: @escaping IntResponse) {
    Alamofire.request(Url.Taxi.Reference.lotCapacity, headers: headers())
      .responseString { resultString  in
        if let string = resultString.result.value {
          response(Int(string))
        } else {
          response(nil)
        }
    }
  }
  
  static func requestVersion(_ response: @escaping DoubleResponse) {
    Alamofire.request(Url.Taxi.Reference.clientVersion, parameters: ["platform":"ios"], headers: headers())
      .responseString { resultString in
        if let string = resultString.result.value {
          response(Double(string))
        } else {
          response(nil)
        }
    }
  }
  
  static func requestTermsAndConditions(_ response: @escaping StringClosure) {
    Alamofire.request(Url.Taxi.Reference.terms, parameters: ["platform":"ios"], headers: headers())
      .responseString { resultString in
        response(resultString.result.value)
    }
  }
  
  static func requestSecurityInfo(_ response: @escaping StringClosure) {
    Alamofire.request(Url.securities, headers: headers())
      .responseObject { (dataResponse: DataResponse<SecurityPageData>) in
        response(dataResponse.result.value?.data)
    }
  }
}
