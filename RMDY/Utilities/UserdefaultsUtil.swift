//
//  UserdefaultsUtil.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import Foundation
import ObjectMapper

enum UserdefaultsKey: String {
    
    case user     = "user"
}

class UserdefaultsUtil {
    
    static let userdefaults = UserDefaults.standard
    
    private class func setObject(for key: UserdefaultsKey, object: Any?) {
        
        self.userdefaults.set(object, forKey: key.rawValue)
        self.userdefaults.synchronize()
    }
    
    private class func getObject(from key: UserdefaultsKey) -> Any? {
        
        return self.userdefaults.value(forKey: key.rawValue)
    }
    
    class func setUser(user: LoginModel) {
        
        self.setObject(for: .user, object: user.toJSONString())
    }
    
    class func getUser() -> LoginModel? {
        
        var loginModel: LoginModel? = nil
        
        if let stringObject = self.getObject(from: .user) as? String {
            
            loginModel = Mapper<LoginModel>().map(JSONString: stringObject)
        }
        
        return loginModel
    }

}
