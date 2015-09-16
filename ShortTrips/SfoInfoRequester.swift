//
//  SfoInfoRequester.swift
//  ShortTrips
//
//  Created by Joshua Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias LotStatusResponseClosure = (LotStatusResponse?, NSError?) -> Void
typealias TerminalResponseClosure = ([TerminalSummary]?, NSError?) -> Void
typealias FlightResponseClosure = ([Flight]?, NSError?) -> Void
typealias AviResponseClosure = ([AutomaticVehicleId]?, NSError?) -> Void
typealias AntennaResponseClosure = (AntennaResponse?, NSError?) -> Void
typealias AllCidsResponseClosure = (AllCidsResponse?, NSError?) -> Void
typealias CidForSmartCardResponseClosure = (CidResponse?, NSError?) -> Void
typealias MobileStateChangesResponseClosure = (NSError?) -> Void
typealias AllGeofencesResponseClosure = (AllGeofencesResponse?, NSError?) -> Void
typealias GeofenceResponseClosure = (GeofenceResponse?, NSError?) -> Void
typealias DriverResponseClosure = (DriverResponse?, NSError?) -> Void

// /taxi/flight/summary
// Endpoint URL: http://localhost:8181/taxiws/services/taxi/flight/summary
// Example: GET http://localhost:8181/taxiws/services/taxi/flight/summary?(hour)

// /taxi/flight/arrival/details
// Endpoint URL: http://localhost:8080/taxiws/services/taxi/flight/arrival/details
// Example: GET http://localhost:8080/taxiws/services/taxi/flight/arrival/details?terminal_id=1&hour=1


class SfoInfoRequester {
  private static let baseUrl = "https://216.9.96.29:9000/taxiws/services/taxi/"
  private static let lotStatusUrl = "lot_status"
  private static let terminalUrl = "flight/summary"
  private static let flightUrl = "flight/arrival/details"
  private static let aviUrl = "device/avi/"
  private static let antennaUrl = "device/avi/transponder/"
  private static let allCidsUrl = "device/cid/"
  private static let cidForSmartCardUrl = "device/cid/smart_card/"
  private static let mobileStateUrl = "device/mobile/state"
  private static let geofenceUrl = "geofence"
  private static let locationUrl = "location"
  private static let driverLoginUrl = "driver/login"

  class func requestLotStatus(response: LotStatusResponseClosure) {
    Alamofire.request(.GET, baseUrl + lotStatusUrl, parameters: nil).responseObject(response)
  }
  
  class func requestTerminals(hour: Int, response: TerminalResponseClosure) {
    let params = ["hour": hour]
    Alamofire.request(.GET, baseUrl + terminalUrl, parameters: params).responseArray(response)
  }
  
  class func requestFlights(terminal: Int, hour: Int, response: FlightResponseClosure) {
    let params = ["terminal_id": terminal, "hour" : hour]
    Alamofire.request(.GET, baseUrl + flightUrl, parameters: params).responseArray(response)
  }
  
  class func requestAutomaticVehicleIds(response: AviResponseClosure) {
    Alamofire.request(.GET, baseUrl + aviUrl, parameters: nil).responseArray(response)
  }

  // Note: Page 16 of the requirements document says that this endpoint has seven possible
  // parameters but indicates that only transponder_id is mandatory. (Actually, transponder_id
  // is not really an HTTP parameter in the tranditional sense. Rather, it forms the last part
  // of the URL.) I don't see how the other parameters are needed to get an antenna_id, so
  // I haven't accounted for the non-mandatory parameters here. For future reference, the non-
  // mandatory parameters are longitude, latitude, trip_id, trip_state, mobile_state, and
  // client_session_id.
  class func requestAntenna(transponderId: Int, response: AntennaResponseClosure) {
    Alamofire.request(.GET, baseUrl + antennaUrl + "\(transponderId)", parameters: nil).responseObject(response)
  }
  
  // Note: The requirements document does not say what "CID" or "cid" mean. The letters might
  // stand for "card ID", but the document implies that "cid" and "smart_card_id" are separate
  // entities, so that guess may be wrong. I therefore retained the unhelpful name "cid" when
  // implementing the network layer and model for cid.
  class func requestAllCids(response: AllCidsResponseClosure) {
    Alamofire.request(.GET, baseUrl + allCidsUrl, parameters: nil).responseObject(response)
  }
  
  class func requestCidForSmartCard(response: CidForSmartCardResponseClosure, smartCardId: Int) {
    Alamofire.request(.GET, baseUrl + cidForSmartCardUrl + "\(smartCardId)", parameters: nil).responseObject(response)
  }
  
  // Note: The requirements document does not explicitly state, as far as I could tell, what the
  // possible enumerated values of trip_state are, but the document implies that they are "SHORT"
  // and "LONG". I therefore created an enum, TripState, for these. I also created an enum,
  // MobileState, for the possible mobile_states, which are listed in the document. As an aside, I
  // have neve never posted with Alamofire before, but this code compiles and appears correct based
  // on Alamofire's readme example.
  
  class func postMobileStateChanges(longitude: Float, latitude: Float, tripId: Int, tripState: TripState, mobileState: MobileState, sessionId: Int, response: MobileStateChangesResponseClosure) {
    let params = ["longitude": "\(longitude)", "latitude": "\(latitude)", "trip_id": "\(tripId)", "trip_state": tripState.rawValue, "mobile_state": mobileState.rawValue, "session_id": "\(sessionId)"]
    Alamofire.request(.POST, baseUrl + mobileStateUrl, parameters: params)
  }

  class func requestAllGeofences(response: AllGeofencesResponseClosure) {
    Alamofire.request(.GET, baseUrl + geofenceUrl, parameters: nil).responseObject(response)
  }
  
  class func requestGeofenceForLocation(longitude: Float, latitude: Float, buffer: Float, response: GeofenceResponseClosure) {
    let params = ["longitude": longitude, "latitude": latitude, "buffer": buffer]
    Alamofire.request(.GET, baseUrl + geofenceUrl + "/" + locationUrl, parameters: params).responseObject(response)
  }
  
  class func requestGeofenceForId(id: Int, response: GeofenceResponseClosure) {
    Alamofire.request(.GET, baseUrl + geofenceUrl + "/" + "\(id)", parameters: nil).responseObject(response)
  }

  class func requestDriver(username: String, password: String, response: DriverResponseClosure) {
    let params = ["username": username, "password": password]
    Alamofire.request(.GET, baseUrl + driverLoginUrl, parameters: params).responseObject(response)
  }
}
