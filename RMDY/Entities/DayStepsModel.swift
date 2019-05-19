//
//  DayStepsModel.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import Foundation
import ObjectMapper

class DayStepsModel: Mappable {
    
    var startDate: String?
    var steps: Double?
    
    init() {
        
    }
    
    func mapping(map: Map) {
        
        startDate           <- map["StartDate"]
        steps               <- map["Steps"]
    }
    
    required init?(map: Map) {
        
    }
}
