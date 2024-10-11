//
//  Helper.swift
//  Chart_Pie_Bar
//
//  Created by Thaw De Zin on 10/11/24.
//

import Foundation
import DGCharts

class PercentageValueFormatter: NSObject, ValueFormatter {
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%.2f%%", value) // Format value as a percentage (e.g., 58%)
    }
}
