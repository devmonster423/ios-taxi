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

typealias GeofencesClosure = ([SfoGeofence]?) -> Void

struct GeofenceArbiter {
  
  static let buffer: Double = 0
  
  static func requestGeofencesForLocation(_ location: CLLocationCoordinate2D, response: @escaping GeofencesClosure) {
    
    DispatchQueue.global(qos: .background).async {
      
      var validGeofences = [SfoGeofence]()
      
      for localGeofence in allGeofences {
        if checkLocation(location, againstFeatures: localGeofence.features) {
          validGeofences.append(localGeofence.sfoGeofence)
        }
      }
      
      DispatchQueue.main.async {
        response(validGeofences)
      }
    }
  }
  
  static func checkLocation(_ location: CLLocationCoordinate2D, againstFeatures features:[LocalGeofenceFeature] = taxiMergedGeofence.features) -> Bool {
    for feature in features {
      if self.location(location, satisfiesPolygonInfo: feature.polygonInfos()) {
        return true
      }
    }
    
    return false
  }
  
  fileprivate static func location(_ location: CLLocationCoordinate2D, satisfiesPolygonInfo polygonInfos:[PolygonInfo]) -> Bool {

    for polygonInfo in polygonInfos {
      if polygonInfo.additive != self.location(location, isInsideRegion: polygonInfo.polygon) {
        return false
      }
    }
    
    return true
  }
  
  private static func location(_ location: CLLocationCoordinate2D, isInsideRegion region: MKPolygon) -> Bool {
    
    let mutablePath = CGMutablePath()
    
    let polygonPoints = region.points()
    
    for index in 0 ..< region.pointCount {
      
      let mapPoint = polygonPoints[index]
      
      if index == 0 {
        mutablePath.move(to: CGPoint(x: mapPoint.x, y: mapPoint.y))
      } else {
        mutablePath.addLine(to: CGPoint(x: mapPoint.x, y: mapPoint.y))
      }
    }
    
    let targetMapPoint = MKMapPointForCoordinate(location)
    return mutablePath.contains(CGPoint(x: targetMapPoint.x, y: targetMapPoint.y))
  }
}
