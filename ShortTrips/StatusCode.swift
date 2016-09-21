//
//  StatusCode.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/16/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

struct StatusCode {
  static func isSuccessful(_ statusCode: Int) -> Bool {
    return 200 <= statusCode && statusCode <= 299
  }
}
