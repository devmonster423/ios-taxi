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
  
  private let usernameTextField = UITextField()
  private let passwordTextField = UITextField()
  let loginButton = UIButton()
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let bgImageView = UIImageView()
    bgImageView.image = Image.blueGrandient.image()
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
    
    usernameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Username", comment: ""), attributes: [NSForegroundColorAttributeName: Color.Auth.offWhite])
    usernameTextField.autocapitalizationType = .None
    usernameTextField.autocorrectionType = .No
    usernameTextField.spellCheckingType = .No
    usernameTextField.textColor = UIColor.whiteColor()
    usernameTextField.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.top.equalTo(logoImage.snp_bottom).offset(10)
      make.width.equalTo(300)
      make.height.equalTo(80)
    }
    
    let divider = UIView()
    divider.backgroundColor = Color.Auth.fadedWhite
    addSubview(divider)
    divider.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(usernameTextField)
      make.trailing.equalTo(usernameTextField)
      make.height.equalTo(1)
      make.top.equalTo(usernameTextField.snp_bottom).offset(10)
    }
    
    passwordTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Password", comment: ""), attributes: [NSForegroundColorAttributeName: Color.Auth.offWhite])
    passwordTextField.secureTextEntry = true
    passwordTextField.textColor = UIColor.whiteColor()
    passwordTextField.snp_makeConstraints { make in
      make.centerX.equalTo(usernameTextField)
      make.top.equalTo(divider.snp_bottom).offset(10)
      make.width.equalTo(usernameTextField)
      make.height.equalTo(usernameTextField)
    }
    
    loginButton.setTitle(NSLocalizedString("Login", comment: "").uppercaseString, forState: .Normal)
    loginButton.titleLabel?.font = Font.MyriadPro.size(24)
    loginButton.backgroundColor = Color.Auth.fadedWhite
    loginButton.snp_makeConstraints { make in
      make.leading.equalTo(self)
      make.top.equalTo(passwordTextField.snp_bottom).offset(10)
      make.trailing.equalTo(self)
      make.height.equalTo(passwordTextField)
    }
  }
  
  func getLoginCredential() -> DriverCredential {
    var credential = DriverCredential()
    credential.username = usernameTextField.text
    credential.password = passwordTextField.text
    return credential
  }
}
