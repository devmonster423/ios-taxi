//
//  ErrorLogger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/5/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Crashlytics
import Foundation

struct ErrorLogger {
  
  static func log(_ request: URLRequest, error: Error?) {
    if let error = error as? NSError, let url = request.url?.absoluteString {
      logError(url, errorText: error.localizedDescription)
    }
  }
  
  private static func logError(_ url: String, errorText: String) {
    Answers.logCustomEvent(withName: "error",
      customAttributes: [
        "url": url,
        "errorText": errorText
      ]
    )
  }
}
