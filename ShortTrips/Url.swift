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

  static func isDevUrl() -> Bool {
    return base == "https://216.9.96.29:9000/taxiws/services/taxi/"
  }
  
  struct Airline {
    fileprivate static let airline = base + "airline/"
    
    static let codes = airline + "codes"
    static func logoPng(_ iataCode: String) -> String {
      return airline + "logo/\(iataCode)"
    }
  }
  
  struct Device {
    fileprivate static let device = base + "device/"
    
    static func mobileStateUpdate(_ stateId: Int) -> String {
      return device + "mobile/state/\(stateId)/update"
    }
    
    struct Avi {
      static let avi = device + "avi"
      
      static func transponder(_ transponderId: Int) -> String {
        return avi + "/transponder/\(transponderId)"
      }
    }
    
    struct Cid {
      fileprivate static let cid = device + "cid"
      
      static func driver(_ driverId: Int) -> String {
        return cid + "/driver/\(driverId)"
      }
      static func singleCid(_ cidId: Int) -> String {
        return cid + "/\(cidId)"
      }
    }
  }
  
  struct Driver {
    fileprivate static let driver = base + "driver/"
    
    static let login = driver + "login"
    
    static func vehicle(_ smartCard: String) -> String {
      return driver + "vehicle/smart_card/\(smartCard)"
    }
  }
  
  struct Flight {
    fileprivate static let flight = base + "flight/"
    
    struct Arrival {
      fileprivate static let arrival = flight + "arrival/"
      
      static let summary = arrival + "summary"
      static let details = arrival + "details"
    }
    
    struct Departure {
      fileprivate static let departure = flight + "departure/"
      
      static let summary = departure + "summary"
      static let details = departure + "details"
    }
  }
  
  struct Geofence {
    static let geofence = base + "geofence/"
    
    static let location = geofence + "location"
    static let locations = geofence + "locations"
    static func singleGeofence(_ geofenceId: Int) -> String {
      return geofence + "\(geofenceId)"
    }
  }
  
  struct Queue {
    static let currentLength = base + "queue/current_size"
  }
  
  struct Reference {
    fileprivate static let reference = base + "reference/"
    
    static let clientVersion = reference + "client_version"
    static let config = reference + "config"
    static let lotCapacity = reference + "lot_capacity"
    static let terms = reference + "terms"
  }
  
  struct Trip {
    fileprivate static let trip = base + "trip/"
    
    static let start = trip + "start"
    static let status = trip + "status"
    static func end(_ tripId: Int) -> String {
      return trip + "\(tripId)/end"
    }
    static func invalidGeofenceDetails(_ tripId: Int) -> String {
      return trip + "\(tripId)/invalid_geofence_details"
    }
    static func invalidate(_ tripId: Int) -> String {
      return trip + "\(tripId)/invalidate"
    }
    static func ping(_ tripId: Int) -> String {
      return trip + "\(tripId)/ping"
    }
    static func pings(_ tripId: Int) -> String {
      return trip + "\(tripId)/delayed_pings"
    }
  }
}
