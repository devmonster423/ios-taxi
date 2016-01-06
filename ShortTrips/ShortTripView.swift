//
//  ShortTripView.swift
//  ShortTrips
//
//  Created by Joshua Adams on 11/24/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class ShortTripView: UIView {
  let countdownLabel = UILabel()
  let countdownSubtitleLabel = UILabel()
  private let currentStateLabel = UILabel()
  let notificationImageView = UIImageView()
  let topImageView = UIImageView()
  private let notificationLabel = UILabel()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    addSubview(countdownLabel)
    addSubview(countdownSubtitleLabel)
    addSubview(currentStateLabel)
    addSubview(notificationImageView)
    addSubview(notificationLabel)
    addSubview(topImageView)
    
    countdownLabel.backgroundColor = Color.Trip.Time.background
    countdownLabel.font = Font.MyriadPro.size(28)
    countdownLabel.textAlignment = .Center
    countdownLabel.textColor = Color.Trip.Time.title
    countdownLabel.snp_makeConstraints { make in
      make.edges.equalTo(notificationLabel)
    }
    
    countdownSubtitleLabel.font = Font.MyriadPro.size(24)
    countdownSubtitleLabel.text = NSLocalizedString("Time Remaining", comment: "")
    countdownSubtitleLabel.textAlignment = .Center
    countdownSubtitleLabel.textColor = Color.Trip.Time.subtitle
    countdownSubtitleLabel.snp_makeConstraints { make in
      make.leading.equalTo(countdownLabel)
      make.trailing.equalTo(countdownLabel)
      make.bottom.equalTo(countdownLabel)
      make.height.equalTo(40)
    }
    
    currentStateLabel.font = Font.MyriadPro.size(28)
    currentStateLabel.textAlignment = .Center
    currentStateLabel.numberOfLines = 0
    currentStateLabel.textColor = Color.Trip.title
    currentStateLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(self).offset(10)
      make.height.equalTo(75)
    }
    
    notificationImageView.contentMode = .ScaleAspectFit
    notificationImageView.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.width.equalTo(200)
      make.height.equalTo(200)
      make.bottom.equalTo(countdownLabel.snp_top).offset(-20)
    }
    
    notificationLabel.backgroundColor = Color.Auth.fadedWhite
    notificationLabel.font = Font.MyriadPro.size(20)
    notificationLabel.numberOfLines = 0
    notificationLabel.textAlignment = .Center
    notificationLabel.textColor = Color.Trip.subtitle
    notificationLabel.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
      make.height.equalTo(150)
    }
    
    topImageView.contentMode = .ScaleAspectFit
    topImageView.clipsToBounds = true
    topImageView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.width.equalTo(notificationImageView)
      make.top.equalTo(currentStateLabel.snp_bottom)
      make.bottom.equalTo(notificationImageView.snp_top).offset(-10)
    }
  }
  
  func updateTitle(title: String) {
    currentStateLabel.text = title
    AVSpeechSynthesizer().speakUtterance(AVSpeechUtterance(string: title))
  }
  
  func notify(notification: String) {
    notificationLabel.text = notification
    
    if !notification.isEmpty {
      countdownLabel.hidden = true
      countdownSubtitleLabel.hidden = true
    }
  }
}
