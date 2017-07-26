//
//  URL.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

struct Url {
  
#if DEBUG
  static let base = "https://api-stage.flysfo.com/taxi_ws/services/" // staging
#else
  static let base = "https://api.flysfo.com/taxi_ws/services/" // prod
#endif

  static let oldBase = "https://216.9.96.29:9999/taxiws/services/taxi/" // old prod

  static func isDevUrl() -> Bool {
    return base == "https://api-stage.flysfo.com/taxi_ws/services/"
  }
  
  static let securities = base + "securities/"
  
  struct Taxi {
    
    static let taxi = base + "taxi/"
    
    struct Airline {
      private static let airline = taxi + "airline/"
      
      static let codes = airline + "codes"
      static func logoPng(_ iataCode: String) -> String {
        return airline + "logo/\(iataCode)"
      }
    }
    
    struct Device {
      private static let device = taxi + "device/"
      
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
        private static let cid = device + "cid"
        
        static func driver(_ driverId: Int) -> String {
          return cid + "/driver/\(driverId)"
        }
        static func singleCid(_ cidId: Int) -> String {
          return cid + "/\(cidId)"
        }
      }
    }
    
    struct Dispatcher {
      private static let dispatcher = taxi + "dispatcher/"
      
      static let cone = dispatcher + "cone"
    }
    
    struct Driver {
      private static let driver = taxi + "driver/"
      
      static let login = driver + "login"
      
      static func vehicle(_ smartCard: String) -> String {
        return driver + "vehicle/smart_card/\(smartCard)"
      }
    }
    
    struct Flight {
      private static let flight = taxi + "flight/"
      
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
      static let geofence = taxi + "geofence/"
      
      static let location = geofence + "location"
      static let locations = geofence + "locations"
      static func singleGeofence(_ geofenceId: Int) -> String {
        return geofence + "\(geofenceId)"
      }
    }
    
    struct Queue {
      static let currentLength = taxi + "queue/current_size"
    }
    
    struct Reference {
      private static let reference = taxi + "reference/"
      
      static let clientVersion = reference + "client_version"
      static let config = reference + "config"
      static let lotCapacity = reference + "lot_capacity"
      static let terms = reference + "terms"
    }
    
    struct Status {
      private static let status = taxi + "status/"
      
      static let queue = status + "queue"
    }
    
    struct Trip {
      private static let trip = taxi + "trip/"
      
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
}
