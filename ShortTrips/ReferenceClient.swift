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
    Alamofire.request(Url.Reference.config, headers: headers())
      .responseObject { (dataResponse: DataResponse<ReferenceConfig>) in
      response(dataResponse.result.value, dataResponse.result.error)
    }
  }
  
  static func requestLotCapacity(_ response: @escaping IntResponse) {
    Alamofire.request(Url.Reference.lotCapacity, headers: headers())
      .responseString { resultString  in
        if let string = resultString.result.value {
          response(Int(string))
        } else {
          response(nil)
        }
    }
  }
  
  static func requestVersion(_ response: @escaping DoubleResponse) {
    Alamofire.request(Url.Reference.clientVersion, parameters: ["platform":"ios"], headers: headers())
      .responseString { resultString in
        if let string = resultString.result.value {
          response(Double(string))
        } else {
          response(nil)
        }
    }
  }
  
  static func requestTermsAndConditions(_ response: @escaping StringClosure) {
    Alamofire.request(Url.Reference.terms, parameters: ["platform":"ios"], headers: headers())
      .responseString { resultString in
        response(resultString.result.value)
    }
  }
  
  static func requestSecurityInfo(_ response: @escaping StringClosure) {
    // TODO: actual URL request
    response("<h3>Be Aware: Potential Indicators of Terrorist/Criminal Activity</h3>Experience gained during past incidents has shown the list below to be potential indicators of terrorist or criminal activity. We can all play a role in keeping us safe by being aware and reporting suspicious behaviors. <b>To report suspicious activity contact: 911</b><br><br><b>NOTE - </b>Each indicator listed below may be, by itself, lawful conduct or behavior and may also constitute the exercise of rights guaranteed by the U.S. Constitution. In addition, there may be a wholly innocent explanation for conduct or behavior that appears suspicious in nature. Some of these activities, taken individually, could be innocent.<br><br><ul><li>Individual is dressed in clothing that is unusual for the weather (e.g. bulky coats when the temperature is warm)</li><li>Individual pays attention to, or avoids surveillance cameras</li><li>Individual’s luggage has a strong odor similar to fingernail polish remover</li><li>Individual does not allow others to touch luggage</li><li>Individual appears nervous and/or is sweating excessively</li><li>Individual pays in cash</li><li>Individual has injuries consistent with experimentation with explosives and chemicals, such as missing fingers or scarring, discoloration, or burns on skin</li><li>Individual shows unusual interest in, or asks questions about security procedures, or engages in overtly suspicious actions to provoke and observe responses by security or law enforcement officers</li></ul>")
  }
}
