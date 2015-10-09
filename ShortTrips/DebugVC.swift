//
//  DebugVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

class DebugVC: UIViewController {
  
  override func loadView() {
    let debugView = DebugView(frame: UIScreen.mainScreen().bounds)
    view = debugView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    debugView().printDebugLine("Debugger Started")
  }
  
  func debugView() -> DebugView {
    return self.view as! DebugView
  }
}
