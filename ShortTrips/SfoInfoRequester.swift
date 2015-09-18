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

typealias LotStatusResponseClosure = (LotStatusResponse?, ErrorType?) -> Void
typealias FlightsForTerminalResponseClosure = (FlightsForTerminalResponse?, ErrorType?) -> Void
typealias TerminalSummaryResponseClosure = (TerminalSummaryResponse?, ErrorType?) -> Void
typealias AviResponseClosure = ([AutomaticVehicleId]?, ErrorType?) -> Void
typealias AntennaResponseClosure = (AntennaResponse?, ErrorType?) -> Void
typealias AllCidsResponseClosure = (AllCidsResponse?, ErrorType?) -> Void
typealias CidForSmartCardResponseClosure = (CidResponse?, ErrorType?) -> Void
typealias ReferenceConfigResponseClosure = (ReferenceConfigResponse?, ErrorType?) -> Void
typealias AllGeofencesResponseClosure = (AllGeofencesResponse?, ErrorType?) -> Void
typealias GeofenceResponseClosure = (GeofenceResponse?, ErrorType?) -> Void
typealias DriverResponseClosure = (DriverResponse?, ErrorType?) -> Void

class SfoInfoRequester {
  private static let baseUrl = "https://216.9.96.29:9000/taxiws/services/taxi/"
  private static let lotStatusUrl = "lot_status"
  private static let terminalSummaryUrl = "flight/arrival/summary"
  private static let flightsForTerminalUrl = "flight/arrival/details"
  private static let aviUrl = "device/avi/"
  private static let antennaUrl = "device/avi/transponder/"
  private static let allCidsUrl = "device/cid/"
  private static let cidForSmartCardUrl = "device/cid/smart_card/"
  private static let mobileStateUrl = "device/mobile/state"
  private static let referenceConfigUrl = "reference/config"
  private static let geofenceUrl = "geofence"
  private static let locationUrl = "location"
  private static let driverLoginUrl = "driver/login"

  class func requestLotStatus(response: LotStatusResponseClosure) {
    Alamofire.request(.GET, baseUrl + lotStatusUrl, parameters: nil).responseObject(response)
  }
  
  class func requestFlightsForTerminal(terminal: Int, hour: Int, response: FlightsForTerminalResponseClosure) {
    let params = ["terminal_id": terminal, "hour" : hour]
    Alamofire.request(.GET, baseUrl + flightsForTerminalUrl, parameters: params).responseObject(response)
  }

  class func requestTerminalSummary(hour: Int, response: TerminalSummaryResponseClosure) {
    let params = ["hour": hour]
    Alamofire.request(.GET, baseUrl + terminalSummaryUrl, parameters: params).responseObject(response)
  }
  
  class func requestAutomaticVehicleIds(response: AviResponseClosure) {
    Alamofire.request(.GET, baseUrl + aviUrl, parameters: nil).responseArray(response)
  }

  class func requestAntenna(transponderId: Int, response: AntennaResponseClosure) {
    Alamofire.request(.GET, baseUrl + antennaUrl + "\(transponderId)", parameters: nil).responseObject(response)
  }
  
  class func requestAllCids(response: AllCidsResponseClosure) {
    Alamofire.request(.GET, baseUrl + allCidsUrl, parameters: nil).responseObject(response)
  }
  
  class func requestCidForSmartCard(response: CidForSmartCardResponseClosure, smartCardId: Int) {
    Alamofire.request(.GET, baseUrl + cidForSmartCardUrl + "\(smartCardId)", parameters: nil).responseObject(response)
  }
  
  class func postMobileStateChanges(mobileStateChange: MobileStateChange) {
    Alamofire.request(.POST, baseUrl + mobileStateUrl, parameters: Mapper().toJSON(mobileStateChange), encoding: .JSON).response { _, _, _, error in
      print(error)
    }
  }

  class func requestReferenceConfig(response: ReferenceConfigResponseClosure) {
    Alamofire.request(.GET, baseUrl + referenceConfigUrl, parameters: nil).responseObject(response)
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
