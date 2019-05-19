//
//  RequestUtil.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import Foundation
import UIKit

enum requestType: String {
    case get = "GET"
    case post = "POST"
}

class RequestUtil {
    
    static var completionHandler:((_ isSuccess: Bool,_ response: String?)->())?
    
    static let successCodes:[Int] = [200, 201, 202, 203, 204, 205, 206, 207, 208, 226]
    
    static var isFaild: Bool = true
    
    class func getData(forAPI api: String, method: requestType, body: String? = nil, headerData: LoginResponse? = nil, completionHandler: @escaping ((_ isSuccess: Bool, _ response: String?)->()))  {
        
        self.completionHandler = completionHandler
        
        if let url = URL(string: api) {
            
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            if let body = body {
                
                request.httpBody = body.data(using: .utf8)
            }
            
            if let authToken = headerData?.authToken {
            
                request.addValue(authToken, forHTTPHeaderField: "AuthToken")
            }
            
            if let sessionToken = headerData?.sessionToken {
            
                request.addValue(sessionToken, forHTTPHeaderField: "SessionToken")
            }

            request.httpMethod = method.rawValue
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let data = data, let dataString = String(data: data, encoding: String.Encoding.utf8), let httpResponse = response as? HTTPURLResponse {
                    
                    handelResponse(response: dataString, statusCode: httpResponse.statusCode)
                } else {
                    
                    handelError(error: error.debugDescription)
                }
            }
            
            task.resume()
        }
    }
    
    static func handelResponse(response: Any?, statusCode: Int) {
        
        if let response = response as? String, successCodes.contains(statusCode) {
            
            self.completionHandler?(true, response)
            
        } else {
            
            handelError(error: response.debugDescription)
        }
    }
    
    static func handelError(error: String) {
        
        UIUtils.showAlertView(text: error)
    }
}
