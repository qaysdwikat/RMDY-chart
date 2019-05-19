//
//  WebServices.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import Foundation
import ObjectMapper

enum URLString: String {

    case login  = "https://dev-mdt-api.wellnesslayers.com/API/Account/Login"
    case trakerData = "https://dev-mdt-api.wellnesslayers.com/API/Trackers/Steps/WithGoal/%@"
}

class WebServices {
    
    class func login(_ data: LoginModel, completionHandler: @escaping ((_ data: LoginResponse?)->())) {
        
        RequestUtil.getData(forAPI: URLString.login.rawValue, method: .post, body: data.toJSONString()) { (isSuccess, data) in
            
            var loginData: LoginResponse? = nil
            
            if let data = data, isSuccess {
            
                loginData = Mapper<LoginResponse>().map(JSONString: data)                
            }
            
            completionHandler(loginData)
        }
    }
    
    class func stepTracker(range: RangeType, completionHandler: @escaping ((_ data: StepsChartData?)->())) {
    
        RequestUtil.getData(forAPI: String(format: URLString.trakerData.rawValue, range.getStringValue()), method: .get) { (isSuccess, data) in
            
            var trakerData: StepsChartData? = nil
            
            if let data = data, isSuccess {
                
                trakerData = Mapper<StepsChartData>().map(JSONString: data)
            }
            
            completionHandler(trakerData)
        }
    }
}
