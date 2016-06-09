//
//  URL.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

struct Url {
  
//#if DEBUG
  static let base = "https://216.9.96.29:9000/taxiws/services/taxi/" // dev
//#else
//  static let base = "https://216.9.96.29:9999/taxiws/services/taxi/" // prod
//#endif
  
  static let queueStatus = base + "status/queue"
  
  struct Airline {
    private static let airline = base + "airline/"
    
    static let codes = airline + "codes"
    static func logoPng(iataCode: String) -> String {
      return airline + "logo/\(iataCode)"
    }
  }
  
  struct Device {
    private static let device = base + "device/"
    
    static func mobileStateUpdate(stateId: Int) -> String {
      return device + "mobile/state/\(stateId)/update"
    }
    
    struct Avi {
      static let avi = device + "avi"
      
      static func transponder(transponderId: Int) -> String {
        return avi + "/transponder/\(transponderId)"
      }
    }
    
    struct Cid {
      private static let cid = device + "cid"
      
      static func driver(driverId: Int) -> String {
        return cid + "/driver/\(driverId)"
      }
      static func singleCid(cidId: Int) -> String {
        return cid + "/\(cidId)"
      }
    }
  }
  
  struct Driver {
    private static let driver = base + "driver/"
    
    static let login = driver + "login"
    
    static func vehicle(smartCard: String) -> String {
      return driver + "vehicle/smart_card/\(smartCard)"
    }
  }
  
  struct Flight {
    private static let flight = base + "flight/"
    
    struct Arrival {
      private static let arrival = flight + "arrival/"
      
      static let summary = arrival + "summary"
      static let details = arrival + "details"
    }
    
    struct Departure {
      private static let departure = flight + "departure/"
      
      static let summary = departure + "summary"
      static let details = departure + "details"
    }
  }
  
  struct Geofence {
    static let geofence = base + "geofence/"
    
    static let location = geofence + "location"
    static let locations = geofence + "locations"
    static func singleGeofence(geofenceId: Int) -> String {
      return geofence + "\(geofenceId)"
    }
  }
  
  struct Queue {
    static let currentLength = base + "queue/current_size"
  }
  
  struct Reference {
    private static let reference = base + "reference/"
    
    static let clientVersion = reference + "client_version"
    static let config = reference + "config"
    static let lotCapacity = reference + "lot_capacity"
    static let terms = reference + "terms"
  }
  
  struct Trip {
    private static let trip = base + "trip/"
    
    static let start = trip + "start"
    static let status = trip + "status"
    static func end(tripId: Int) -> String {
      return trip + "\(tripId)/end"
    }
    static func invalidGeofenceDetails(tripId: Int) -> String {
      return trip + "\(tripId)/invalid_geofence_details"
    }
    static func invalidate(tripId: Int) -> String {
      return trip + "\(tripId)/invalidate"
    }
    static func ping(tripId: Int) -> String {
      return trip + "\(tripId)/ping"
    }
    static func pings(tripId: Int) -> String {
      return trip + "\(tripId)/delayed_pings"
    }
  }
}
