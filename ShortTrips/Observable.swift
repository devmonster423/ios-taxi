//
//  Notifiable.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/28/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

protocol Observable {
  func eventWasFired(info: Any?)
}
