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

typealias AirlinesClosure = ([Airline]?) -> Void
typealias ImageClosure = (UIImage?) -> Void

extension ApiClient {
  static var airlineImages:[String:UIImage] = Dictionary()
  
  static func imageForIataCode(_ iataCode: String, width: Int, height: Int, completion: @escaping ImageClosure) {
    if let airlineImage = airlineImages[iataCode] {
      completion(airlineImage);
    }
    else {
      let params = ["width": width, "height": height]
      Alamofire.request(Url.Airline.logoPng(iataCode), parameters: params, headers: headers())
        .responseImage { response in
          
          if airlineImages[iataCode] == nil {
            airlineImages[iataCode] = response.result.value
          }
          completion(response.result.value)
        }
    }
  }
  
  static func codes(_ completion: @escaping AirlinesClosure) {
    Alamofire.request(Url.Airline.codes, headers: headers())
      .responseObject { (dataResponse: DataResponse<AirlineListWrapper>) in
        completion(dataResponse.result.value?.airlines)
    }
  }
}
