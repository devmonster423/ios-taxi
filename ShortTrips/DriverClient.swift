//
//  DriverClient.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias DriverClosure = (DriverCredential, Driver?) -> Void

protocol DriverClient { }

extension ApiClient {
  static func authenticateDriver(credential: DriverCredential, completion: DriverClosure) {
    authedRequest(Alamofire.request(.POST, Url.Driver.login, parameters: Mapper().toJSON(credential)))
      .responseObject { (driverResponse: DriverResponse?, error) in
        completion(credential, driverResponse?.driver)
    }
  }
}
