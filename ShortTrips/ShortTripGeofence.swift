//
//  ShortTripGeofence.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import MapKit

var ShortTripGeofence: MKPolygon {
  
  var points = [CLLocationCoordinate2D]()
  
  // TODO: replace these coordinates with actual data
  // these are the 4 corners of Colorado :]
  points.append(CLLocationCoordinate2D(latitude: 41.000512, longitude: -109.050116))
  points.append(CLLocationCoordinate2D(latitude: 41.002371, longitude: -102.052066))
  points.append(CLLocationCoordinate2D(latitude: 36.993076, longitude: -102.041981))
  points.append(CLLocationCoordinate2D(latitude: 36.99892, longitude: -109.045267))
  
  return MKPolygon(coordinates: &points, count: 4)
}
