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
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let blurBgImageView = UIImageView()
    blurBgImageView.image = Image.bgBlur.image()
    addSubview(blurBgImageView)
    blurBgImageView.snp_makeConstraints { make in
      make.edges.equalTo(self)
    }
    
    addSubview(currentStateLabel)
    addSubview(notificationImageView)
    addSubview(notificationLabel)
    
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
    
    notificationImageView.contentMode = .ScaleAspectFit
    notificationImageView.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.width.equalTo(200)
      make.top.equalTo(currentStateLabel.snp_bottom)
      make.bottom.equalTo(notificationLabel.snp_top)
    }
    
    notificationLabel.backgroundColor = Color.Auth.fadedWhite
    notificationLabel.font = Font.MyriadPro.size(14)
    notificationLabel.textAlignment = .Center
    notificationLabel.numberOfLines = 0
    notificationLabel.text = "Notification: TBD"
    notificationLabel.textColor = UIColor.whiteColor()
    notificationLabel.snp_makeConstraints { make in
      make.leading.equalTo(self).offset(30)
      make.trailing.equalTo(self).offset(-30)
      make.bottom.equalTo(self).offset(-30)
      make.height.equalTo(75)
    }
  }
}