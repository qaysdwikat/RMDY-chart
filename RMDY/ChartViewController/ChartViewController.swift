//
//  ChartViewController.swift
//  RMDY
//
//  Created by Qays Dwekat on 5/18/19.
//  Copyright © 2019 Qays Dwekat. All rights reserved.
//

import UIKit
import SwiftChart

enum RangeType: Int {
    
    case week           = 0
    case month          = 1
    case quarter        = 2
    
    func getStringValue() -> String {
        
        switch self {
            
        case .week:
            return "Week"
            
        case .month:
            return "Month"
            
        case .quarter:
            return "Quarter"
        }
    }
    
    func getDateFormat() -> String {
        
        switch self {
            
        case .week:
            return "E dd"
            
        case .month, .quarter:
            return "MMM yy"
            
        }
    }
}

class ChartViewController: UIViewController {
    
    @IBOutlet weak var chartView: Chart?

    var rangeType: RangeType = .week
    
    var formatHash: [Int: Double] = [:]
    
    var xLabels:[String] = []
    
    override func viewDidLoad() {
    
        super.viewDidLoad()

        self.chartView?.minY = 0
        
        getSteps()
    }
    
    func setChartData(_ steps: [DayStepsModel]) {
        
        chartView?.removeAllSeries()
        
        xLabels = []
        
        formatHash = [:]
        
        var stepsArry:[Double] = []
        var xformat:[Double] = []
        
        for (i, step) in steps.enumerated() {
            
            if let steps = step.steps {
                
                stepsArry.append(steps)
            }
            
            if let startDate = step.startDate {
            
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

                let monthDateFormatter = DateFormatter()
                monthDateFormatter.dateFormat = self.rangeType.getDateFormat()

                if let date = dateFormatter.date(from: startDate) {

                    let month = monthDateFormatter.string(from: date)

                    if xLabels.contains(month) {
                        
                        continue
                    }
                    
                    xLabels.append(month)
                    
                    formatHash[i] = date.timeIntervalSince1970
                    
                    xformat.append(Double(i))
                }
            }
        }
        
        let series = ChartSeries(stepsArry)
        
        chartView?.xLabels = xformat
        
        // Format the labels with a unit
        chartView?.xLabelsFormatter = {  [weak self] (index, value) -> String in
            
            let date = Date(timeIntervalSince1970: self?.formatHash[Int(value)] ?? 0.0)
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = self?.rangeType.getDateFormat()
            
            return dateFormatterPrint.string(from: date)
        }

        chartView?.add(series)
    }
    
    
    @IBAction func rangeAction(_ sender: Any) {
        
        if let index = (sender as? UISegmentedControl)?.selectedSegmentIndex, let type = RangeType(rawValue: index) {
           
            self.rangeType = type
            
            getSteps(type)
        }
    }
    
    func getSteps(_ range: RangeType = .week) {
        
        WebServices.stepTracker(range: range) { [weak self] stepsObject in
          
            DispatchQueue.main.async {
                
                if let data = stepsObject?.graphData, let goal = stepsObject?.goal {
                    
                    self?.chartView?.maxY = goal
                    
                    self?.setChartData(data)
                }
            }
        }
    }
}
