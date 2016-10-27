//
//  ConeView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/21/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit
import SnapKit

class ConeView: UIView {
  
  private let lastUpdatedLabel = UILabel()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.white
    
    let footerBgView = UIView()
    footerBgView.backgroundColor = Color.Dashboard.gray
    addSubview(footerBgView)
    footerBgView.snp.makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
      make.height.equalTo(100)
    }
    
    let fullLabel = UILabel()
    fullLabel.font = Font.OpenSans.size(42)
    fullLabel.text = NSLocalizedString("Full", comment: "")
    fullLabel.textColor = UIColor.white
    fullLabel.backgroundColor = Color.Dashboard.orange
    fullLabel.textAlignment = .center
    addSubview(fullLabel)
    fullLabel.snp.makeConstraints { make in
      make.leading.equalTo(self)
      make.top.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(80)
    }
    
    let coneImageView = UIImageView()
    coneImageView.image = Image.cone.image()
    coneImageView.contentMode = .scaleAspectFit
    addSubview(coneImageView)
    coneImageView.snp.makeConstraints { make in
      make.leading.equalTo(self).offset(20)
      make.trailing.equalTo(self).offset(-20)
      make.top.equalTo(fullLabel.snp.bottom).offset(20)
      make.bottom.equalTo(footerBgView.snp.top).offset(-20)
    }
    
    lastUpdatedLabel.textColor = Color.Dashboard.darkBlue
    lastUpdatedLabel.textAlignment = .center
    lastUpdatedLabel.font = Font.OpenSansSemibold.size(36)
    addSubview(lastUpdatedLabel)
    lastUpdatedLabel.snp.makeConstraints { make in
      make.leading.equalTo(self).offset(20)
      make.trailing.equalTo(self).offset(-20)
      make.bottom.equalTo(footerBgView).offset(-10)
      make.height.equalTo(30)
    }
    
    let placedAtLabel = UILabel()
    placedAtLabel.font = Font.OpenSans.size(28)
    placedAtLabel.text = NSLocalizedString("Placed at", comment: "")
    placedAtLabel.textColor = Color.Dashboard.darkGray
    placedAtLabel.textAlignment = .center
    addSubview(placedAtLabel)
    placedAtLabel.snp.makeConstraints { make in
      make.leading.equalTo(self).offset(20)
      make.trailing.equalTo(self).offset(-20)
      make.top.equalTo(footerBgView).offset(10)
      make.height.equalTo(30)
    }
  }
  
  func updateForCone(_ cone: Cone) {
    isHidden = !cone.isConed
    lastUpdatedLabel.text = cone.lastUpdatedString()
  }
}
