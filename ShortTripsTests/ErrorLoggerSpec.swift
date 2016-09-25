//
//  ErrorLogger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/23/15.
//  Copyright © 2015 SFO. All rights reserved.
//

@testable import ShortTrips
import Quick
import Nimble
import Foundation

class ErrorLoggerSpec: QuickSpec {
  
  override func spec() {
    describe("the ErrorLogger") {
      
      it("can log a request") {
        ErrorLogger.log(URLRequest(url: URL(string: "http://www.google.com")!), error: NSError(domain: "", code: 500, userInfo: nil))
      }
    }
  }
}
