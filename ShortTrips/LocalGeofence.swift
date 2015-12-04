//
//  JsonGeofence.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/1/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import MapKit

struct LocalGeofence {

  static func polygons(rings: [[[Double]]]) -> [MKPolygon] {

    var polygons = [MKPolygon]()

    for ring in rings {

      var points = [CLLocationCoordinate2D]()

      for point in ring {
        points.append(CLLocationCoordinate2D(latitude: point[1], longitude: point[0]))
      }

      polygons.append(MKPolygon(coordinates: &points, count: points.count))
    }

    return polygons
  }
}
