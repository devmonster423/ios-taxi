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
  
  static let buffer: Double = 0
  
  static func requestGeofencesForLocation(location: CLLocationCoordinate2D, response: MultipleGeofencesClosure) {
    
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      
      var validGeofences = [Geofence]()
      
      for localGeofence in allGeofences {
        if checkLocation(location, againstFeatures: localGeofence.features) {
          validGeofences.append(Geofence(localGeofence))
        }
      }
      
      dispatch_async(dispatch_get_main_queue()) {
        response(validGeofences)
      }
    }
  }
  
  static func checkLocation(location: CLLocationCoordinate2D, againstFeatures features:[LocalGeofenceFeature] = taxiMergedGeofence.features) -> Bool {
    for feature in features {
      if self.location(location, satisfiesPolygonInfo: feature.polygonInfos()) {
        return true
      }
    }
    
    return false
  }
  
  private static func location(location: CLLocationCoordinate2D, satisfiesPolygonInfo polygonInfos:[PolygonInfo]) -> Bool {

    for polygonInfo in polygonInfos {
      if polygonInfo.additive != self.location(location, isInsideRegion: polygonInfo.polygon) {
        return false
      }
    }
    
    return true
  }
  
  private static func location(location: CLLocationCoordinate2D, isInsideRegion region: MKPolygon) -> Bool {
    
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
}
