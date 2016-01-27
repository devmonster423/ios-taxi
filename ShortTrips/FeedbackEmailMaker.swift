//
//  FeedbackEmailMaker.swift
//  ShortTrips
//
//  Created by Matt Luedke on 1/26/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import Foundation
import MessageUI
import CoreTelephony

struct FeedbackEmailMaker {
  static func make(delegate: MFMailComposeViewControllerDelegate) -> MFMailComposeViewController {
    
    var messageBody = "\n\n\n\n\n"
      + UIDevice.currentDevice().modelName
      + "\n"
      + UIDevice.currentDevice().systemName
      + " "
      + UIDevice.currentDevice().systemVersion
    
    if let carrier = CTTelephonyNetworkInfo().subscriberCellularProvider?.carrierName {
      messageBody += "\n" + carrier
    }
    
    let mc: MFMailComposeViewController = MFMailComposeViewController()
    mc.setSubject("App Feedback")
    mc.setMessageBody(messageBody, isHTML: false)
    mc.setToRecipients(["taxiops@flysfo.com"])
    mc.mailComposeDelegate = delegate
    
    return mc
  }
}
