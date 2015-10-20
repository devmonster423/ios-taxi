//
//  TerminalSummaryMock.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/19/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation

var TerminalSummaryMock =
[
  "response":
    [
      "arrivals":
        [
          "list":
            [
              [
                "count": 4,
                "delayed_count": 2,
                "terminal_id": 1
              ]
            ]
        ]
    ]
]

// {"response":{"arrivals":{"list":[{"count":4,"delayed_count":2,"terminal_id":1},{"count":7,"delayed_count":2,"terminal_id":2},{"count":13,"delayed_count":5,"terminal_id":3},{"count":5,"delayed_count":1,"terminal_id":4}],"total_count":29,"total_delayed_count":10}}}
