//
//  AirlineClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import AlamofireImage
import AlamofireObjectMapper

typealias AirlinesClosure = ([Airline]?, Error?) -> Void
typealias ImageClosure = (UIImage?) -> Void

extension ApiClient {
  static var airlineImages:[String:UIImage] = Dictionary()
  
  static func imageForIataCode(_ iataCode: String, width: Int, height: Int, completion: ImageClosure) {
    if let airlineImage = airlineImages[iataCode] {
      completion(airlineImage);
    }
    else {
      let params = ["width": width, "height": height]
      authedRequest(.GET, Url.Airline.logoPng(iataCode), parameters: params).responseImage { (_, _, result) -> Void in
        if airlineImages[iataCode] == nil {
          airlineImages[iataCode] = result.value
        }
        completion(result.value)
      }
    }
  }
  
  static func codes(_ completion: @escaping AirlinesClosure) {
    authedRequest(.GET, Url.Airline.codes).responseObject { (airlineListWrapper: AirlineListWrapper?, error) -> Void in
      completion(airlineListWrapper?.airlines, error)
    }
  }
}
