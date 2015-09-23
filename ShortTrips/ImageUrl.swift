//
//  ImageUrl.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

struct ImageUrl {

  private static let base = "http://stg-tncsvc01.flysfo.com:9080/als/services/logo/"

  static func iataCode(iataCode: String) -> String {
    return base + iataCode
  }
}
