//
//  RequestDebugger.swift
//  ShortTrips
//
//  Created by Matt Luedke on 11/3/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import JSQNotificationObserverKit

extension DebugVC {
  
  func setupRequestObservers() {
    responseObserver = NotificationObserver(notification: SfoNotification.Request.response, handler: { response, _ in
      self.debugView().printDebugLine("URL: \(response.URL!)\nstatusCode: \(response.statusCode)",
        type: StatusCode.isSuccessful(response.statusCode) ? .Positive : .Negative )
    })
  }
}
