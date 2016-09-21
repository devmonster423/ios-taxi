//
//  InsideBufferedExit.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/26/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import TransitionKit
import JSQNotificationObserverKit

class InsideBufferedExit {
  let eventNames = ["InsideBufferedExit"]
  static let sharedInstance = InsideBufferedExit()
  
  fileprivate var events: [TKEvent]
  
  fileprivate init() {
    events = [
      TKEvent(name: eventNames[0],
        transitioningFromStates: [InProgress.sharedInstance.getState()],
        to: WaitingForReEntryCid.sharedInstance.getState())
    ]
  }
}

extension InsideBufferedExit: Event {
  func getEvents() -> [TKEvent] {
    return events
  }
}
