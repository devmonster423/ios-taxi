//
//  DriverRequester.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol DriverClient { }

extension ApiClient {
  static func authenticateDriver(credential: Credential) {
    authedRequest(Alamofire.request(.POST, Url.Driver.login, parameters: Mapper().toJSON(credential), encoding: .JSON))
      .response { _, _, _, error in
      print(error)
    }
  }
}
