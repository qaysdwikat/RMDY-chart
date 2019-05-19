//
//  LoginModel.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginModel: Mappable {
    
    var userName: String?
    var password: String?
    var tenantID:Int = 1

    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        userName            <- map["UserName"]
        password            <- map["Password"]
        tenantID            <- map["TenantID"]
    }
}
