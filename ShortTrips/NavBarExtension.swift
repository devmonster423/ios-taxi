//
//  NavBarExtension.swift
//  ShortTrips
//
//  Created by Matt Luedke on 12/18/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit

extension UIViewController {
  func configureNavBar(back: Bool = false, title: String) {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navigationController?.navigationBar.setBackgroundImage(Image.from(Color.NavBar.backgroundBlue).stretchableImage(withLeftCapWidth: 0, topCapHeight: 0), for: .default)
    
    if back {
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.backButton.image(), style: .plain, target: self, action: #selector(UIViewController.goBack))
      navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    } else {
      let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UiConstants.Dashboard.titleWidth, height: UiConstants.Dashboard.titleHeight-5))
      titleImageView.image = Image.sfoLogoAlpha.image()
      titleImageView.contentMode = .scaleAspectFit
      navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleImageView)
    }
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UiConstants.Dashboard.titleWidth, height: UiConstants.Dashboard.titleHeight))
    titleLabel.text = title
    titleLabel.textColor = UIColor.white
    titleLabel.font = Font.OpenSansSemibold.size(18)
    navigationItem.titleView = titleLabel
  }
    
  func goBack() {
    navigationController?.popViewController(animated: true)
  }
}
