//
//  LocalGeofenceSpec.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/11/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation
import ObjectMapper

class LocalGeofenceSpec: QuickSpec {
  
  override func spec() {
    describe("the domestic pickup geofence") {
      
      it("can parse") {
        
        let path = NSBundle.mainBundle().pathForResource("Domestic_Pax_Pickup", ofType: "json")!
        
        var jsonString: String!
        
        do {
          jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        } catch {}
        
        let geofence = Mapper<LocalGeofence>().map(jsonString!)
        
        expect(geofence).toNot(beNil())
      }
    }

    describe("the entry gate geofence") {
      
      it("can parse") {
        
        let path = NSBundle.mainBundle().pathForResource("Entry_Gate", ofType: "json")!
        
        var jsonString: String?
        
        do {
          jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        }
        catch {}
        
        let geofence = Mapper<LocalGeofence>().map(jsonString!)
        
        expect(geofence).toNot(beNil())
      }
    }

    describe("the international pickup geofence") {
      
      it("can parse") {
        
        let path = NSBundle.mainBundle().pathForResource("International_Pax_Pickup", ofType: "json")!
        
        var jsonString: String?
        
        do {
          jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        }
        catch {}
        
        let geofence = Mapper<LocalGeofence>().map(jsonString!)
        
        expect(geofence).toNot(beNil())
      }
    }

    describe("the sfo geofence") {
      
      it("can parse") {
        
        let path = NSBundle.mainBundle().pathForResource("SFO", ofType: "json")!
        
        var jsonString: String?
        
        do {
          jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        }
        catch {}
        
        let geofence = Mapper<LocalGeofence>().map(jsonString!)
        
        expect(geofence).toNot(beNil())
      }
    }
    
    describe("the terminal exit geofence") {
      
      it("can parse") {
        
        let path = NSBundle.mainBundle().pathForResource("Terminal_Exit", ofType: "json")!
        
        var jsonString: String?
        
        do {
          jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        }
        catch {}
        
        let geofence = Mapper<LocalGeofence>().map(jsonString!)
        
        expect(geofence).toNot(beNil())
      }
    }

    describe("the valid cities geofence") {
      
      it("can parse") {
        
        let path = NSBundle.mainBundle().pathForResource("Valid_Cities", ofType: "json")!
        
        var jsonString: String?
        
        do {
          jsonString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        }
        catch {}
        
        let geofence = Mapper<LocalGeofence>().map(jsonString!)
        
        expect(geofence).toNot(beNil())
      }
    }
  }
}
