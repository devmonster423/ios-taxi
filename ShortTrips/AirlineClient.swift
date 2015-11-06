//
//  AirlineClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

typealias AirlinesClosure = ([Airline]?, ErrorType?) -> Void
typealias ImageClosure = UIImage? -> Void

protocol AirlineClient {}

extension ApiClient {
  static func imageForIataCode(iataCode: String, width: Int, height: Int, completion: ImageClosure) {
    
    let params = ["width": width, "height": height]
    authedRequest(Alamofire.request(.GET, Url.Airline.logoPng(iataCode), parameters: params)).responseImage { (_, _, result) -> Void in
      completion(result.value)
    }
  }
  
  static func codes(completion: AirlinesClosure) {
    authedRequest(Alamofire.request(.GET, Url.Airline.codes)).responseObject { (airlineList: AirlineList?, error) -> Void in
      completion(airlineList?.airlines, error)
    }
  }
}
