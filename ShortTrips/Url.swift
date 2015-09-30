//
//  URL.swift
//  ShortTrips
//
//  Created by Matt Luedke on 9/21/15.
//  Copyright © 2015 SFO. All rights reserved.
//

struct Url {
  
  private static let base = "https://216.9.96.29:9000/taxiws/services/taxi/"
  
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
    
    static let mobileState = device + "mobile/state"
    
    struct Avi {
      static let avi = device + "avi"
      
      static func transponder(transponderId: Int) -> String {
        return avi + "/transponder/\(transponderId)"
      }
    }
    
    struct Cid {
      static let cid = device + "cid"
      
      static func smartCard(smartCardId: Int) -> String {
        return cid + "/smart_card/\(smartCardId)"
      }
      static func singleCid(cidId: Int) -> String {
        return cid + "/\(cidId)"
      }
    }
  }
  
  struct Dispatcher {
    private static let dispatcher = base + "dispatcher/"
    
    static let holdingLotCapacity = dispatcher + "holdinglot/capacity"
  }
  
  struct Driver {
    private static let driver = base + "driver/"
    
    static let login = driver + "login"
  }
  
  struct Flight {
    private static let flight = base + "flight/"
    
    static let summary = flight + "summary"
    
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
    static func singleGeofence(geofenceId: Int) -> String {
      return geofence + "\(geofenceId)"
    }
  }
  
  struct Reference {
    private static let reference = base + "reference/"
    
    static let config = reference + "config"
    static let state = reference + "state"
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
  }
}
