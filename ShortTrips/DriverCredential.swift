//
//  DriverCredential.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct DriverCredential: Mappable {
  var username: String!
  var password: String!
  var osVersion: String!
  var deviceOs: String!
  var longitude: String?
  var latitude: String?
  var deviceUuid: String!

  
  init(username: String, password: String) {
    self.username = username
    self.password = password
    self.deviceOs = "ios"
    self.osVersion = UIDevice.current.systemVersion
    self.deviceUuid = UIDevice.current.identifierForVendor!.uuidString
    if let location = LocationManager.sharedInstance.getLastKnownLocation() {
      self.latitude = "\(location.coordinate.latitude)"
      self.longitude = "\(location.coordinate.longitude)"
    }
  }
  
  init() {}
  
  init?(map: Map){}
  
  mutating func mapping(map: Map) {
    username <- map["username"]
    password <- map["password"]
    osVersion <- map["os_version"]
    deviceOs <- map["device_os"]
    longitude <- map["longitude"]
    latitude <- map["latitude"]
    deviceUuid <- map["device_uuid"]
  }
  
  static func test() -> DriverCredential {
    var credential = DriverCredential()
    credential.username = "test"
    return credential
  }
  
  func save() {
    
    DriverCredential.clear()
    
    let credential = URLCredential(user: username,
      password: password,
      persistence: .permanent)
    
    URLCredentialStorage.shared.set(
      credential, for: DriverCredential.credentialProtectionSpace()
    )
  }
  
  static func load() -> DriverCredential? {
    let credentials = URLCredentialStorage.shared
      .credentials(for: DriverCredential.credentialProtectionSpace())
    if let credential = credentials?.first?.1,
      let username = credential.user,
      let password = credential.password {
      return DriverCredential(username: username, password: password)
    } else {
      return nil
    }
  }
  
  static func clear() {
    let credentials = URLCredentialStorage.shared
      .credentials(for: DriverCredential.credentialProtectionSpace())
    if let credential = credentials?.first?.1 {
      URLCredentialStorage.shared.remove(
          credential, for: DriverCredential.credentialProtectionSpace()
      )
    }
  }
  
  private static func credentialProtectionSpace() -> URLProtectionSpace {
    let url = NSURL(string: Url.base)!
    return URLProtectionSpace(host: url.host!,
      port: (url.port?.intValue) ?? 8080,
      protocol: url.scheme,
      realm: nil,
      authenticationMethod: NSURLAuthenticationMethodHTTPDigest)
  }
}
