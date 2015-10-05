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
  
  static func log(request: NSURLRequest, error: ErrorType?) {
    if let error = error as? NSError {
      logError(request.URLString, errorText: error.localizedDescription)
    }
  }
  
  private static func logError(url: String, errorText: String) {
    Answers.logCustomEventWithName("error",
      customAttributes: [
        "url": url,
        "errorText": errorText
      ]
    )
  }
}
