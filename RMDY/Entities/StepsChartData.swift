//
//  StepsChartData.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import Foundation
import ObjectMapper

class StepsChartData: Mappable {

    var graphData: [DayStepsModel]?
    var goal: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        graphData       <- map["GraphData"]
        goal            <- map["Goal"]
    }
}
