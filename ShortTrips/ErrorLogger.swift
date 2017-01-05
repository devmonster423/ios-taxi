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
  
  private static let errorTextKey = "errorText"
  private static let errorKey = "error"
  private static let urlKey = "url"
  
  static func log(_ request: URLRequest?, error: Error?) {
    if let error = error as? NSError, let url = request?.url?.absoluteString {
      logError(url, errorText: error.localizedDescription)
    }
  }
  
  static func log(errorString: String) {
    Answers.logCustomEvent(withName: errorKey, customAttributes: [errorTextKey: errorString])
  }
  
  private static func logError(_ url: String, errorText: String) {
    Answers.logCustomEvent(withName: errorKey,
      customAttributes: [
        urlKey: url,
        errorTextKey: errorText
      ]
    )
  }
}
