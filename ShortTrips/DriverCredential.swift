//
//  Credential.swift
//  ShortTrips
//
//  Created by Joshua Adams on 9/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import ObjectMapper

struct DriverCredential: Mappable {
  var username: String!
  var password: String!
  var macAddress: String!
  var osVersion: String!
  var deviceOs: String!
  var longitude: String!
  var latitude: String!
  
  init(username: String, password: String) {
    self.username = username
    self.password = password
  }
  
  init() {}
  
  init?(_ map: Map){}
  
  mutating func mapping(map: Map) {
    username <- map["username"]
    password <- map["password"]
    macAddress <- map["mac_address"]
    osVersion <- map["os_version"]
    deviceOs <- map["device_os"]
    longitude <- map["longitude"]
    latitude <- map["latitude"]
  }
  
  static func test() -> DriverCredential {
    var credential = DriverCredential()
    credential.username = "test"
    return credential
  }
  
  func save() {
    
    DriverCredential.clear()
    
    let credential = NSURLCredential(user: username,
      password: password,
      persistence: .Permanent)
    
    NSURLCredentialStorage.sharedCredentialStorage()
      .setCredential(credential,
        forProtectionSpace: DriverCredential.credentialProtectionSpace())
  }
  
  static func load() -> DriverCredential? {
    let credentials = NSURLCredentialStorage.sharedCredentialStorage()
      .credentialsForProtectionSpace(DriverCredential.credentialProtectionSpace())
    if let credential = credentials?.first?.1 {
      var driverCredential = DriverCredential()
      driverCredential.username = credential.user
      driverCredential.password = credential.password
      return driverCredential
    } else {
      return nil
    }
  }
  
  static func clear() {
    let credentials = NSURLCredentialStorage.sharedCredentialStorage()
      .credentialsForProtectionSpace(DriverCredential.credentialProtectionSpace())
    if let credential = credentials?.first?.1 {
      NSURLCredentialStorage.sharedCredentialStorage()
        .removeCredential(credential,
          forProtectionSpace: DriverCredential.credentialProtectionSpace())
    }
  }
  
  static func credentialProtectionSpace() -> NSURLProtectionSpace {
    let url = NSURL(string: Url.base)!
    return NSURLProtectionSpace(host: url.host!,
      port: (url.port?.integerValue)!,
      `protocol`: url.scheme,
      realm: nil,
      authenticationMethod: NSURLAuthenticationMethodHTTPDigest)
  }
}