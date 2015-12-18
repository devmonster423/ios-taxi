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
    
    backgroundColor = Color.Sfo.gray
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
  }
}