//
//  SecurityVC.swift
//  ShortTrips
//
//  Created by Matt Luedke on 6/26/17.
//  Copyright © 2017 SFO. All rights reserved.
//

import UIKit
import MBProgressHUD

class SecurityVC: UIViewController {
  
  override func loadView() {
    view = SecurityView(frame: UIScreen.main.bounds)
  }
  
  func securityView() -> SecurityView {
    return view as! SecurityView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud.label.text = NSLocalizedString("Requesting Lot Status", comment: "")
    ApiClient.requestSecurityInfo { info in
      if let info = info {
        self.securityView().loadHTMLString(info)
      }
      hud.hide(animated: true)
    }
  }
}
