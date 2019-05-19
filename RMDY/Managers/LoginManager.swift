//
//  LoginManager.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import Foundation

class LoginManager {
    
    static let shareInstance:LoginManager = LoginManager()
    
    var loginModel: LoginModel?
    
    var tokens:LoginResponse?
    
    private init() {
        
        loginModel = UserdefaultsUtil.getUser()
    }
}
