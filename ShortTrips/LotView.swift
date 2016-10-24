//
//  LotView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/21/16.
//  Copyright © 2016 SFO. All rights reserved.
//

import UIKit
import SnapKit

class LotView: UIView {
  
  private let numberLabel = UILabel()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let taxisCaptionLabel = UILabel()
    taxisCaptionLabel.backgroundColor = Color.Dashboard.lightBlue
    taxisCaptionLabel.font = Font.OpenSansBold.size(32)
    taxisCaptionLabel.text = NSLocalizedString("Taxis in lot", comment: "").uppercased()
    taxisCaptionLabel.textAlignment = .center
    taxisCaptionLabel.textColor = Color.Dashboard.darkBlue
    addSubview(taxisCaptionLabel)
    taxisCaptionLabel.snp.makeConstraints { make in
      make.height.equalTo(105)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
    
    let circlesImage = UIImageView()
    circlesImage.image = Image.bgCircles.image()
    circlesImage.contentMode = .scaleAspectFit
    addSubview(circlesImage)
    circlesImage.snp.makeConstraints { make in
      make.top.equalTo(self).offset(20)
      make.bottom.equalTo(taxisCaptionLabel.snp.top).offset(-20)
      make.leading.equalTo(self).offset(50)
      make.trailing.equalTo(self).offset(-50)
    }
    
    numberLabel.font = Font.OpenSansBold.size(180)
    numberLabel.textAlignment = .center
    numberLabel.textColor = Color.Dashboard.darkBlue
    addSubview(numberLabel)
    numberLabel.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(circlesImage.snp.centerX)
      make.centerY.equalTo(circlesImage.snp.centerY)
    }
  }
  
  func updateSpots(_ length: Int) {
    numberLabel.text = "\(length)"
  }
}
