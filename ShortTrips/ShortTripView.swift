//
//  ShortTripView.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class ShortTripView: UIView {
  let currentStateLabel = UILabel()
  let notificationImageView = UIImageView()
  let notificationLabel = UILabel()
  let logOutButton = UIButton()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = Color.Sfo.gray
    addSubview(currentStateLabel)
    addSubview(notificationImageView)
    addSubview(notificationLabel)
    addSubview(logOutButton)
    
    currentStateLabel.font = Font.MyriadPro.size(28)
    currentStateLabel.textAlignment = .Center
    currentStateLabel.numberOfLines = 0
    currentStateLabel.text = "Current State: TBD"
    currentStateLabel.textColor = UIColor.whiteColor()
    currentStateLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(self).offset(32)
      make.bottom.equalTo(notificationImageView.snp_top)
      make.height.equalTo(75)
    }
    
    notificationImageView.image = UIImage(named: "unknownArline.png")
    notificationImageView.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }
    
    notificationLabel.font = Font.MyriadPro.size(14)
    notificationLabel.textAlignment = .Center
    notificationLabel.numberOfLines = 0
    notificationLabel.text = "Notification: TBD"
    notificationLabel.textColor = UIColor.whiteColor()
    notificationLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
      make.height.equalTo(75)
    }
    
    // Logout Button
    logOutButton.setTitle(NSLocalizedString("Logout", comment: "").uppercaseString, forState: .Normal)
    logOutButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    logOutButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
    logOutButton.setBackgroundImage(Image.from(UIColor.blackColor()), forState: .Normal)
    logOutButton.setBackgroundImage(Image.from(UIColor.blackColor()), forState: .Highlighted)
    logOutButton.titleLabel?.font = Font.MyriadProSemibold.size(UiConstants.Dashboard.buttonFontSize)
    logOutButton.layer.borderColor = UIColor.whiteColor().CGColor
    logOutButton.layer.borderWidth = UiConstants.Dashboard.statusBorderWidth
    logOutButton.layer.cornerRadius = UiConstants.Dashboard.statusCornerRadius
    logOutButton.clipsToBounds = true
    logOutButton.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(UiConstants.Dashboard.shortTripWidth)
      make.height.equalTo(UiConstants.Dashboard.buttonHeight)
      make.bottom.equalTo(notificationLabel.snp_top).offset(UiConstants.Dashboard.buttonMargin)
      make.top.equalTo(notificationImageView.snp_bottom)
      make.centerX.equalTo(self.snp_centerX)
    }
  }
}