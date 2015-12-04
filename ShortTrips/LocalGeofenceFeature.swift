//
//  LocalGeofenceFeature.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/4/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import ObjectMapper
import MapKit

struct LocalGeofenceFeature: Mappable {

  var rings: [[[Double]]]!

  init?(_ map: Map){}

  mutating func mapping(map: Map) {
    rings <- map["geometry.rings"]
  }

  func polygons() -> [MKPolygon] {

    var polygons = [MKPolygon]()

    for ring in self.rings {

      var points = [CLLocationCoordinate2D]()

      for point in ring {
        points.append(CLLocationCoordinate2D(latitude: point[1], longitude: point[0]))
      }

      polygons.append(MKPolygon(coordinates: &points, count: points.count))
    }

    return polygons
  }
}