//
//  DebugVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import CoreLocation

class DebugVC: UIViewController {
  
  override func loadView() {
    let debugView = DebugView(frame: UIScreen.mainScreen().bounds)
    debugView.logOutButton.addTarget(self,
      action: "logout",
      forControlEvents: .TouchUpInside)
    view = debugView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    debugView().printDebugLine("started location manager", type: .BigDeal)
    LocationManager.sharedInstance.delegate = self
  }
  
  func debugView() -> DebugView {
    return self.view as! DebugView
  }
  
  func logout() {
    DriverCredential.clear()
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
}

extension DebugVC: LocationManagerDelegate {
  func readLocation(location: CLLocation) {
    debugView().printDebugLine("read location: (\(location.coordinate.latitude), \(location.coordinate.longitude)) at \(location.timestamp)")
  }
  
  func attemptingPingAtLocation(ping: Ping) {
    debugView().printDebugLine("attempting ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
  }
  
  func successfulPingAtLocation(ping: Ping) {
    debugView().printDebugLine("succesful ping: (\(ping.latitude), \(ping.longitude)) at \(ping.timestamp)")
  }
}
