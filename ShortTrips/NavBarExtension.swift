//
//  NavBarExtension.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

extension UIViewController {
  func configureNavBar(back back: Bool = false, title: String) {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    navigationController?.navigationBar.setBackgroundImage(Image.from(Color.NavBar.backgroundBlue).stretchableImageWithLeftCapWidth(0, topCapHeight: 0), forBarMetrics: .Default)
    
    if back {
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.backButton.image(), style: .Plain, target: self, action: #selector(UIViewController.goBack))
      navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
    } else {
      let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UiConstants.Dashboard.titleWidth, height: UiConstants.Dashboard.titleHeight-5))
      titleImageView.image = Image.sfoLogoAlpha.image()
      titleImageView.contentMode = .ScaleAspectFit
      navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleImageView)
    }
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UiConstants.Dashboard.titleWidth, height: UiConstants.Dashboard.titleHeight))
    titleLabel.text = title
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.font = Font.OpenSansSemibold.size(18)
    navigationItem.titleView = titleLabel
  }
    
  func goBack() {
    navigationController?.popViewControllerAnimated(true)
  }
}
