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

struct SfoInfoRequester {
  
  static func requestLotStatus(response: LotStatusClosure) {
    Alamofire.request(.GET, Url.queueStatus, parameters: nil).responseObject { (statusResponse: LotStatusResponse?, error: ErrorType?) in
      response(statusResponse?.lotStatus, error)
    }
  }

  static func requestFlightsForTerminal(terminal: Int, hour: Int, response: FlightsForTerminalClosure) {
    let params = ["terminal_id": terminal, "hour": hour]
    Alamofire.request(.GET, Url.Flight.Arrival.details, parameters: params).responseObject { (flightsForTerminalResponse: FlightsForTerminalResponse?, error: ErrorType?) in
      response(flightsForTerminalResponse?.flightDetailResponse?.flightDetails, error)
    }
  }
  
  static func requestTerminalSummary(hour: Int, response: TerminalSummaryClosure) {
    let params = ["hour": hour]
    Alamofire.request(.GET, Url.Flight.Arrival.summary, parameters: params).responseObject { (terminalSummaryResponse: TerminalSummaryResponse?, error: ErrorType?) in response(terminalSummaryResponse?.terminalSummaryArrivalsResponse?.terminalSummaryArrivalsListResponse?.terminalSummaryArrivalsListListResponse?.terminalSummaryArrivalsList, error)
    }
  }
  
  static func requestAutomaticVehicleIds(response: AviClosure) {
    Alamofire.request(.GET, Url.Device.Avi.avi, parameters: nil).responseObject { (aviResponse: AutomaticVehicleIdResponse?, error: ErrorType?) in
      response(aviResponse?.automaticVehicleIds, error)
    }
  }

  static func requestAntenna(transponderId: Int, response: AntennaClosure) {
    Alamofire.request(.GET, Url.Device.Avi.transponder(transponderId), parameters: nil).responseObject { (antennaResponse: AntennaResponse?, error: ErrorType?) in
      response(antennaResponse?.antenna, error)
    }
  }
  
  static func requestAllCids(response: AllCidsClosure) {
    Alamofire.request(.GET, Url.Device.Cid.cid, parameters: nil).responseObject { (allCidsResponse: AllCidsResponse?, error: ErrorType?) in
      response(allCidsResponse?.cidListResponse?.cidList, error)
    }
  }
  
  static func requestCidForSmartCard(smartCardId: Int, response: CidForSmartCardClosure) {
    Alamofire.request(.GET, Url.Device.Cid.smartCard(smartCardId), parameters: nil).responseObject { (cidResponse: CidResponse?, error: ErrorType?) in
      response(cidResponse?.cid, error)
    }
  }
  
  static func requestReferenceConfig(response: ReferenceConfigClosure) {
    Alamofire.request(.GET, Url.Reference.config, parameters: nil).responseObject { (referenceConfigResponse: ReferenceConfigResponse?, error: ErrorType?) in
      response(referenceConfigResponse?.referenceConfig, error)
    }
  }
  
  static func requestAllGeofences(response: AllGeofencesClosure) {
    Alamofire.request(.GET, Url.Geofence.geofence, parameters: nil).responseObject { (allGeofencesResponse: AllGeofencesResponse?, error: ErrorType?) in
      response(allGeofencesResponse?.geofenceListResponse?.geofenceList, error)
    }
  }
  
  static func requestGeofenceForLocation(longitude: Float, latitude: Float, buffer: Float, response: GeofenceClosure) {
    let params = ["longitude": longitude, "latitude": latitude, "buffer": buffer]
    Alamofire.request(.GET, Url.Geofence.location, parameters: params).responseObject { (geofenceResponse: GeofenceResponse?, error: ErrorType?) in
      response(geofenceResponse?.geofence, error)
    }
  }
  
  static func requestGeofenceForId(id: Int, response: GeofenceClosure) {
    Alamofire.request(.GET, Url.Geofence.singleGeofence(id), parameters: nil).responseObject { (geofenceResponse: GeofenceResponse?, error: ErrorType?) in
      response(geofenceResponse?.geofence, error)
    }
  }

  static func authenticateDriver(credential: Credential) {
    Alamofire.request(.POST, Url.Driver.login, parameters: Mapper().toJSON(credential), encoding: .JSON).response { _, _, _, error in
      print(error)
    }
  }
  
  static func postMobileStateChanges(mobileStateChange: MobileStateChange) {
    Alamofire.request(.POST, Url.Device.mobileState, parameters: Mapper().toJSON(mobileStateChange), encoding: .JSON).response { _, _, _, error in
      print(error)
    }
  }
}
