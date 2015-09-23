//
//  ImageClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

typealias ImageClosure = (UIImage?) -> Void

protocol ImageClient {
  static func imageForIataCode(iataCode: String, size: CGSize, completion: ImageClosure)
}

extension ApiClient {
  static func imageForIataCode(iataCode: String, size: CGSize, completion: ImageClosure) {
    let params = ["width": size.width, "height": size.height]
    Alamofire.request(.GET, ImageUrl.iataCode(iataCode), parameters: params).responseImage { (_, _, result) -> Void in
      completion(result.value)
    }
  }
}
