//
//  RequestDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

extension DebugVC {
  
  func setupRequestObservers() {
    sfoObservers.responseObserver = NotificationObserver(notification: SfoNotification.Request.response, handler: { response, _ in
      self.debugView().printDebugLine("URL: \(response.URL!)\nstatusCode: \(response.statusCode)",
        type: StatusCode.isSuccessful(response.statusCode) ? .Positive : .Negative )
    })
  }
}
