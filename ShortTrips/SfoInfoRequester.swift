//
//  SfoInfoRequester.swift
//  ShortTrips
//
//  Created by Josh Adams on 8/13/15.
//  Copyright (c) 2015 SFO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias LotStatusClosure = (LotStatus?, ErrorType?) -> Void
typealias FlightsForTerminalClosure = ([Flight]?, ErrorType?) -> Void
typealias TerminalSummaryClosure = ([TerminalSummary]?, ErrorType?) -> Void
typealias AviClosure = ([AutomaticVehicleId]?, ErrorType?) -> Void
typealias AntennaClosure = (Antenna?, ErrorType?) -> Void
typealias AllCidsClosure = ([Cid]?, ErrorType?) -> Void
typealias CidForSmartCardClosure = (Cid?, ErrorType?) -> Void
typealias ReferenceConfigClosure = (ReferenceConfig?, ErrorType?) -> Void
typealias AllGeofencesClosure = ([Geofence]?, ErrorType?) -> Void
typealias GeofenceClosure = (Geofence?, ErrorType?) -> Void
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
  
  class func requestLotStatus(response: LotStatusClosure) {
    Alamofire.request(.GET, baseUrl + lotStatusUrl, parameters: nil).responseObject { (statusResponse: LotStatusResponse?, error: ErrorType?) in
      response(statusResponse?.lotStatus, error)
    }
  }

  class func requestFlightsForTerminal(terminal: Int, hour: Int, response: FlightsForTerminalClosure) {
    let params = ["terminal_id": terminal, "hour": hour]
    Alamofire.request(.GET, baseUrl + flightsForTerminalUrl, parameters: params).responseObject { (flightsForTerminalResponse: FlightsForTerminalResponse?, error: ErrorType?) in
      response(flightsForTerminalResponse?.flightDetailResponse?.flightDetails, error)
    }
  }
  
  class func requestTerminalSummary(hour: Int, response: TerminalSummaryClosure) {
    let params = ["hour": hour]
    Alamofire.request(.GET, baseUrl + terminalSummaryUrl, parameters: params).responseObject { (terminalSummaryResponse: TerminalSummaryResponse?, error: ErrorType?) in response(terminalSummaryResponse?.terminalSummaryArrivalsResponse?.terminalSummaryArrivalsListResponse?.terminalSummaryArrivalsListListResponse?.terminalSummaryArrivalsList, error)
    }
  }
  
  class func requestAutomaticVehicleIds(response: AviClosure) {
    Alamofire.request(.GET, baseUrl + aviUrl, parameters: nil).responseObject { (aviResponse: AutomaticVehicleIdResponse?, error: ErrorType?) in
      response(aviResponse?.automaticVehicleIds, error)
    }
  }

  class func requestAntenna(transponderId: Int, response: AntennaClosure) {
    Alamofire.request(.GET, baseUrl + antennaUrl + "\(transponderId)", parameters: nil).responseObject { (antennaResponse: AntennaResponse?, error: ErrorType?) in
      response(antennaResponse?.antenna, error)
    }
  }
  
  class func requestAllCids(response: AllCidsClosure) {
    Alamofire.request(.GET, baseUrl + allCidsUrl, parameters: nil).responseObject { (allCidsResponse: AllCidsResponse?, error: ErrorType?) in
      response(allCidsResponse?.cidListResponse?.cidList, error)
    }
  }
  
  class func requestCidForSmartCard(smartCardId: Int, response: CidForSmartCardClosure) {
    Alamofire.request(.GET, baseUrl + cidForSmartCardUrl + "\(smartCardId)", parameters: nil).responseObject { (cidResponse: CidResponse?, error: ErrorType?) in
      response(cidResponse?.cid, error)
    }
  }
  
  class func requestReferenceConfig(response: ReferenceConfigClosure) {
    Alamofire.request(.GET, baseUrl + referenceConfigUrl, parameters: nil).responseObject { (referenceConfigResponse: ReferenceConfigResponse?, error: ErrorType?) in
      response(referenceConfigResponse?.referenceConfig, error)
    }
  }
  
  class func requestAllGeofences(response: AllGeofencesClosure) {
    Alamofire.request(.GET, baseUrl + geofenceUrl, parameters: nil).responseObject { (allGeofencesResponse: AllGeofencesResponse?, error: ErrorType?) in
      response(allGeofencesResponse?.geofenceListResponse?.geofenceList, error)
    }
  }
  
  class func requestGeofenceForLocation(longitude: Float, latitude: Float, buffer: Float, response: GeofenceClosure) {
    let params = ["longitude": longitude, "latitude": latitude, "buffer": buffer]
    Alamofire.request(.GET, baseUrl + geofenceUrl + "/" + locationUrl, parameters: params).responseObject { (geofenceResponse: GeofenceResponse?, error: ErrorType?) in
      response(geofenceResponse?.geofence, error)
    }
  }
  
  class func requestGeofenceForId(id: Int, response: GeofenceClosure) {
    Alamofire.request(.GET, baseUrl + geofenceUrl + "/" + "\(id)", parameters: nil).responseObject { (geofenceResponse: GeofenceResponse?, error: ErrorType?) in
      response(geofenceResponse?.geofence, error)
    }
  }

  class func authenticateDriver(credential: Credential) {
    Alamofire.request(.POST, baseUrl + driverLoginUrl, parameters: Mapper().toJSON(credential), encoding: .JSON).response { _, _, _, error in
      print(error)
    }
  }
  
  class func postMobileStateChanges(mobileStateChange: MobileStateChange) {
    Alamofire.request(.POST, baseUrl + mobileStateUrl, parameters: Mapper().toJSON(mobileStateChange), encoding: .JSON).response { _, _, _, error in
      print(error)
    }
  }
}
