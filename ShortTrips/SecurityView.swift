//
//  SecurityView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 6/26/17.
//  Copyright © 2017 SFO. All rights reserved.
//

import UIKit
import SnapKit

class SecurityView: UIView {
  
  let webView = UIWebView()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(webView)
    
    webView.snp.makeConstraints { make in
      make.edges.equalTo(self)
    }
  }
  
  func loadHTMLString(_ html: String) {
    let font = Font.OpenSans.size(14)
    
    let htmlString = "<span style=\"font-family: \(font.fontName); font-size: \(font.pointSize); color:#\(Color.Dashboard.darkBlueHexString);\">" + html + "</span>"
    
    webView.loadHTMLString(htmlString, baseURL: nil)
  }
}
