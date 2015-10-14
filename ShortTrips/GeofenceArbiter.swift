//
//  GeofenceArbiter.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/6/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

import CoreLocation
import MapKit

struct GeofenceArbiter {
  
  static let buffer = 1.0
  
  static func location(location: CLLocationCoordinate2D, isInsideRegion region: MKPolygon) -> Bool {
    
    let mutablePathRef = CGPathCreateMutable()
    
    let polygonPoints = region.points()
    
    for var index = 0; index < region.pointCount; index++ {
      
      let mapPoint = polygonPoints[index]
      
      if index == 0 {
        CGPathMoveToPoint(mutablePathRef, nil, CGFloat(mapPoint.x), CGFloat(mapPoint.y))
      } else {
        CGPathAddLineToPoint(mutablePathRef, nil, CGFloat(mapPoint.x), CGFloat(mapPoint.y))
      }
    }
    
    let mapPoint = MKMapPointForCoordinate(location)
    let pointasCGP = CGPointMake(CGFloat(mapPoint.x), CGFloat(mapPoint.y))
    
    return CGPathContainsPoint(mutablePathRef, nil, pointasCGP, false)
  }

  static func processGeofences(geofences: [Geofence]) {
    for geofence in geofences {
      if let identifiedGeofence = SfoGeofence.find(geofence) {
        switch identifiedGeofence {
        case .SFO:
          EnteredSFOGeofence.sharedInstance.fire()
        }
      }
    }
  }
}
