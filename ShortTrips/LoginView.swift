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
    
    addSubview(usernameTextField)
    addSubview(passwordTextField)
    addSubview(loginButton)
    
    backgroundColor = UIColor.whiteColor()
    
    usernameTextField.placeholder = NSLocalizedString("Username", comment: "")
    usernameTextField.snp_makeConstraints { make in
      make.centerX.equalTo(self)
      make.top.equalTo(self).offset(100)
      make.width.equalTo(300)
      make.height.equalTo(80)
    }
    
    passwordTextField.placeholder = NSLocalizedString("Password", comment: "")
    passwordTextField.snp_makeConstraints { make in
      make.centerX.equalTo(usernameTextField)
      make.top.equalTo(usernameTextField.snp_bottom).offset(50)
      make.width.equalTo(usernameTextField)
      make.height.equalTo(usernameTextField)
    }
    
    loginButton.setTitle(NSLocalizedString("Login", comment: ""), forState: .Normal)
    loginButton.backgroundColor = UIColor.blueColor()
    loginButton.snp_makeConstraints { make in
      make.centerX.equalTo(passwordTextField)
      make.top.equalTo(passwordTextField.snp_bottom).offset(50)
      make.width.equalTo(passwordTextField)
      make.height.equalTo(passwordTextField)
    }
  }
  
  func getLoginCredential() -> Credential {
    var credential = Credential()
    credential.username = usernameTextField.text
    credential.password = passwordTextField.text
    return credential
  }
}
