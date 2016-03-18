//
//  LoginView.swift
//  ShortTrips
//
//  Created by Matt Luedke on 10/9/15.
//  Copyright © 2015 SFO. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
  
  let usernameTextField = UITextField()
  private let passwordTextField = UITextField()
  let loginButton = UIButton()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let bgImageView = UIImageView()
    bgImageView.image = Image.blueGradient.image()
    addSubview(bgImageView)
    bgImageView.snp_makeConstraints { make in
      make.edges.equalTo(self)
    }
    
    addSubview(usernameTextField)
    addSubview(passwordTextField)
    addSubview(loginButton)
    
    let logoImage = UIImageView(image: Image.sfoLogoAndName.image())
    logoImage.contentMode = .ScaleAspectFit
    addSubview(logoImage)
    logoImage.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self)
      make.top.equalTo(self).offset(75)
      make.height.equalTo(40)
      make.width.equalTo(150)
    }
    
    let usernameLabel = UILabel()
    usernameLabel.font = Font.OpenSans.size(14)
    usernameLabel.text = NSLocalizedString("Username", comment: "") + ":"
    usernameLabel.textColor = Color.Auth.offWhite
    addSubview(usernameLabel)
    usernameLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(logoImage.snp_bottom).offset(10)
      make.leading.equalTo(self).offset(25)
      make.height.equalTo(50)
      make.width.equalTo(100)
    }
    
    usernameTextField.autocapitalizationType = .None
    usernameTextField.autocorrectionType = .No
    usernameTextField.spellCheckingType = .No
    usernameTextField.textColor = UIColor.whiteColor()
    usernameTextField.snp_makeConstraints { make in
      make.leading.equalTo(usernameLabel.snp_trailing).offset(10)
      make.top.equalTo(usernameLabel)
      make.trailing.equalTo(self).offset(-25)
      make.height.equalTo(usernameLabel)
    }
    
    let divider = UIView()
    divider.backgroundColor = Color.Auth.fadedWhite
    addSubview(divider)
    divider.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(usernameLabel)
      make.trailing.equalTo(usernameTextField)
      make.height.equalTo(1)
      make.top.equalTo(usernameTextField.snp_bottom).offset(10)
    }
    
    let passwordLabel = UILabel()
    passwordLabel.font = Font.OpenSans.size(14)
    passwordLabel.text = NSLocalizedString("Password", comment: "") + ":"
    passwordLabel.textColor = Color.Auth.offWhite
    addSubview(passwordLabel)
    passwordLabel.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(usernameLabel)
      make.trailing.equalTo(usernameLabel)
      make.height.equalTo(usernameLabel)
      make.top.equalTo(divider.snp_bottom).offset(10)
    }
    
    passwordTextField.secureTextEntry = true
    passwordTextField.textColor = UIColor.whiteColor()
    passwordTextField.snp_makeConstraints { make in
      make.leading.equalTo(usernameTextField)
      make.top.equalTo(passwordLabel)
      make.width.equalTo(usernameTextField)
      make.height.equalTo(usernameTextField)
    }
    
    loginButton.setTitle(NSLocalizedString("Login", comment: "").uppercaseString, forState: .Normal)
    loginButton.titleLabel?.font = Font.OpenSans.size(24)
    loginButton.backgroundColor = Color.Auth.fadedWhite
    loginButton.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.top.equalTo(passwordTextField.snp_bottom).offset(10)
      make.trailing.equalTo(self)
      make.height.equalTo(80)
    }
  }
  
  func getLoginCredential() -> DriverCredential? {
    if let username = usernameTextField.text,
      let password = passwordTextField.text {
    return DriverCredential(username: username, password: password)
    } else {
      return nil
    }
  }
}
