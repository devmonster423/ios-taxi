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

typealias PolygonInfo = (polygon: MKPolygon, additive: Bool)

struct LocalGeofenceFeature: Mappable {

  var rings: [[[Double]]]!

  init?(map: Map){}

  mutating func mapping(map: Map) {
    rings <- map["geometry.rings"]
  }

  func polygonInfos() -> [PolygonInfo] {

    var polygons = [PolygonInfo]()

    for ring in self.rings {

      var points = [CLLocationCoordinate2D]()

      for point in ring {
        points.append(CLLocationCoordinate2D(latitude: point[1], longitude: point[0]))
      }
      
      let polygon = MKPolygon(coordinates: &points, count: points.count)

      polygons.append((polygon: polygon, additive: ringIsClockwise(ring)))
    }

    return polygons
  }
  
  // thanks to http://stackoverflow.com/a/1165943/2577986
  fileprivate func ringIsClockwise(_ ring: [[Double]]) -> Bool {
    var clockwisiness: Double = 0
    
    for i in 0..<ring.count {
      let currentCoord = ring[i]
      let nextCoord = i < ring.count - 1 ? ring[i+1] : ring[0]
      
      clockwisiness += (nextCoord[0] - currentCoord[0]) * (nextCoord[1] + currentCoord[1])
    }
    
    return clockwisiness > 0
  }
}
