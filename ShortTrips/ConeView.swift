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
    
    addSubview(lastUpdatedLabel)
    
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
    addSubview(fullLabel)
    fullLabel.snp.makeConstraints { make in
      make.leading.equalTo(self)
      make.top.equalTo(self)
      make.trailing.equalTo(self)
      make.height.equalTo(80)
    }
    
    let coneImageView = UIImageView()
    coneImageView.image = Image.cone.image()
    addSubview(coneImageView)
    coneImageView.snp.makeConstraints { make in
      make.leading.equalTo(self).offset(20)
      make.trailing.equalTo(self).offset(20)
      make.top.equalTo(fullLabel.snp.bottom)
      make.bottom.equalTo(footerBgView.snp.top)
    }
    
    let placedAtLabel = UILabel()
    addSubview(placedAtLabel)
    placedAtLabel.snp.makeConstraints { make in
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.top.equalTo(footerBgView).offset(20)
      make.bottom.equalTo(lastUpdatedLabel.snp.top)
    }
    
    lastUpdatedLabel.textColor = Color.Dashboard.darkBlue
    lastUpdatedLabel.snp.makeConstraints { make in
      make.leading.equalTo(self).offset(20)
      make.trailing.equalTo(self).offset(20)
      make.bottom.equalTo(self).offset(20)
      make.height.equalTo(40)
    }
  }
  
  func updateForCone(_ cone: Cone) {
    isHidden = !cone.isConed
    lastUpdatedLabel.text = cone.lastUpdatedString()
  }
}
