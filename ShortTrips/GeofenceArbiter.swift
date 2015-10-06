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
  
  static func location(location: CLLocationCoordinate2D, isInsideRegion region: MKPolygon) -> Bool {
    
   // let mutablePathRef = CGPathCreateMutable()
    
//    CGMutablePathRef mpr = CGPathCreateMutable();
//    
//    MKMapPoint *polygonPoints = myPolygon.points;
//    //myPolygon is the MKPolygon
//    
//    for (int p=0; p < myPolygon.pointCount; p++)
//    {
//      MKMapPoint mp = polygonPoints[p];
//      if (p == 0)
//      CGPathMoveToPoint(mpr, NULL, mp.x, mp.y);
//      else
//      CGPathAddLineToPoint(mpr, NULL, mp.x, mp.y);
//    }
//    
//    CGPoint mapPointAsCGP = CGPointMake(mapPoint.x, mapPoint.y);
//    //mapPoint above is the MKMapPoint of the coordinate we are testing.
//    //Putting it in a CGPoint because that's what CGPathContainsPoint wants.
//    
//    BOOL pointIsInPolygon = CGPathContainsPoint(mpr, NULL, mapPointAsCGP, FALSE);
//    
//    CGPathRelease(mpr);
    
    return true
  }
}
