//
//  LoginResponse.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse: Mappable {
    
    var authToken: String?
    var sessionToken: String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        authToken               <- map["Tokens.AuthToken"]
        sessionToken            <- map["Tokens.SessionToken"]
    }
}
