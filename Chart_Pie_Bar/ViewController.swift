//
//  ViewController.swift
//  Chart_Pie_Bar
//
//  Created by BCMBSTLP-03 on 05/09/2024.
//

import UIKit
import DGCharts

class ViewController: UIViewController {
    
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPieChart()
        setPieChartData()
        setupBarChart()
    }
    
    func setupBarChart(){
        // Sample data entries (replace with your actual data)
        let values: [Double] = [150, 180, 130, 160, 190, 220, 200, 180, 170, 160, 210, 220]
        var barEntries: [BarChartDataEntry] = []
        
        for (index, value) in values.enumerated() {
            let barEntry = BarChartDataEntry(x: Double(index), y: value)
            barEntries.append(barEntry)
        }
        
        // Create dataset and set properties
        let dataSet = BarChartDataSet(entries: barEntries, label: "Monthly Data")
        dataSet.colors = [UIColor.systemBlue] // Set bar color
        dataSet.valueFont = .systemFont(ofSize: 10) // Adjust value font size
        
        // Customize bar chart data
        let data = BarChartData(dataSet: dataSet)
        data.setValueFormatter(DefaultValueFormatter(decimals: 0)) // No decimals for bar values
        
        // Customize x-axis
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = 45 // Rotate the labels
        xAxis.granularity = 1 // Ensure every label is shown
        xAxis.labelCount = values.count
        //xAxis.forceLabelsEnabled = true
        xAxis.drawGridLinesEnabled = false
        
        // Example x-axis labels (replace with actual labels)
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        
        // Customize y-axis
        let leftAxis = barChartView.leftAxis
        leftAxis.axisMinimum = 0 // Ensure the y-axis starts at 0
        
        // Remove the right axis
        barChartView.rightAxis.enabled = false
        
        // Set chart data
        barChartView.data = data
        
        // Customize chart appearance
        barChartView.chartDescription.enabled = false // Hide description
        barChartView.legend.enabled = false // Hide legend
        
        // Refresh chart
        barChartView.notifyDataSetChanged()
    }
    
    func setupPieChart() {
        pieChartView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        pieChartView.center = view.center
        view.addSubview(pieChartView)
        
        // Pie Chart Customization
        pieChartView.drawHoleEnabled = true  // No hole in the middle
        pieChartView.holeRadiusPercent = 0.75 // စုစုပေါင်းပုံရဲ့ 75% ယူထား
        pieChartView.rotationEnabled = true   // Allow rotation of the pie chart
        pieChartView.isUserInteractionEnabled = true // Enable user interaction
        pieChartView.centerText = "Hello Pie Chart"
        
        // Legend customization (optional)
        let legend = pieChartView.legend
        legend.form = .circle //ပုံအောက် စာသားရှေ့က icon ဒီဇိုင်း
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.xEntrySpace = 7
        legend.yEntrySpace = 0
        legend.yOffset = 10
    }
    
    func setPieChartData() {
        let entry1 = PieChartDataEntry(value: 50, label: "Category A")
        let entry2 = PieChartDataEntry(value: 40, label: "Category B")
        let entry3 = PieChartDataEntry(value: 30, label: "Category C")
        let entry4 = PieChartDataEntry(value: 20, label: "Category D")
        let entry5 = PieChartDataEntry(value: 10, label: "Category E")
        
        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3, entry4, entry5], label: "")
        
        // Pie chart colors
        dataSet.colors = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemYellow, UIColor.systemGreen, UIColor.systemPink]
        
        // Customize appearance
        dataSet.sliceSpace = 2.0  // Space between slices
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.2
        dataSet.yValuePosition = .outsideSlice // Label စာသားကို အထဲပြ or အပြင်ပြ
        
        // Value customization
        dataSet.valueTextColor = UIColor.black
        dataSet.valueFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        
        // Disable entry labels (optional)
        pieChartView.entryLabelColor = .red
    }
    
    
}

