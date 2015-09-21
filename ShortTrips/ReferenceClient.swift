//
//  ReferenceRequester.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias ReferenceConfigClosure = (ReferenceConfig?, ErrorType?) -> Void

protocol ReferenceClient {
  static func requestReferenceConfig(response: ReferenceConfigClosure)
}

extension ApiClient {
  static func requestReferenceConfig(response: ReferenceConfigClosure) {
    Alamofire.request(.GET, Url.Reference.config, parameters: nil).responseObject { (referenceConfigResponse: ReferenceConfigResponse?, error: ErrorType?) in
      response(referenceConfigResponse?.referenceConfig, error)
    }
  }
}
