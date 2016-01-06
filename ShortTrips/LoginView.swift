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
    
    let blurBgImageView = UIImageView()
    blurBgImageView.image = Image.bgBlur.image()
    addSubview(blurBgImageView)
    blurBgImageView.snp_makeConstraints { make in
      make.edges.equalTo(self)
    }
    
    addSubview(usernameTextField)
    addSubview(passwordTextField)
    addSubview(loginButton)
    
    usernameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Username", comment: ""), attributes: [NSForegroundColorAttributeName: Color.Auth.offWhite])
    usernameTextField.autocapitalizationType = .None
    usernameTextField.autocorrectionType = .No
    usernameTextField.spellCheckingType = .No
    usernameTextField.textColor = UIColor.whiteColor()
    usernameTextField.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.top.equalTo(self).offset(100)
      make.width.equalTo(300)
      make.height.equalTo(80)
    }
    
    passwordTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Password", comment: ""), attributes: [NSForegroundColorAttributeName: Color.Auth.offWhite])
    passwordTextField.secureTextEntry = true
    passwordTextField.textColor = UIColor.whiteColor()
    passwordTextField.snp_makeConstraints { make in
      make.centerX.equalTo(usernameTextField)
      make.top.equalTo(usernameTextField.snp_bottom).offset(50)
      make.width.equalTo(usernameTextField)
      make.height.equalTo(usernameTextField)
    }
    
    loginButton.setTitle(NSLocalizedString("Login", comment: ""), forState: .Normal)
    loginButton.backgroundColor = Color.Auth.buttonBlue
    loginButton.snp_makeConstraints { make in
      make.centerX.equalTo(passwordTextField)
      make.top.equalTo(passwordTextField.snp_bottom).offset(50)
      make.width.equalTo(passwordTextField)
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
