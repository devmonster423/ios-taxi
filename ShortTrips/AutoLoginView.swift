//
//  AutoLoginView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import Foundation
import SnapKit

class AutoLoginView: UIView {
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.whiteColor()
    
    let logoImageView = UIImageView()
    logoImageView.contentMode = .ScaleAspectFit
    logoImageView.image = Image.splashLogo.image()
    addSubview(logoImageView)
    logoImageView.snp.makeConstraints { make in
      make.center.equalTo(self)
      make.height.equalTo(100)
      make.width.equalTo(100)
    }
  }
}
