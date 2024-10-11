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
    @IBOutlet weak var barChartView: CombinedChartView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPieChart()
        setPieChartData()
        setupBarChart()
    }
    
    func setupBarChart() {
            // 1. Configure the chart view frame and background color
            //barChartView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
            //barChartView.backgroundColor = .white
            
            // 2. Create Line Chart Data Entries
            // 2.1. Create Line Chart Data Entries (Orange Line)
            let lineValues1: [Double] = [40, 35, 65, 87, 85]
            var lineEntries1: [ChartDataEntry] = []
            
            for (index, value) in lineValues1.enumerated() {
                let lineEntry = ChartDataEntry(x: Double(index) + 0.62, y: value)
                lineEntries1.append(lineEntry)
            }
            
            let lineDataSet1 = LineChartDataSet(entries: lineEntries1, label: "Orange Line")
            lineDataSet1.colors = [UIColor.orange]
            lineDataSet1.circleColors = [UIColor.orange]
            lineDataSet1.circleRadius = 10.0
            lineDataSet1.circleHoleRadius = 5.0
            lineDataSet1.valueFont = .systemFont(ofSize: 10)
            lineDataSet1.drawValuesEnabled = true
            lineDataSet1.axisDependency = .right // Ensure it's linked to the right axis
            lineDataSet1.valueFormatter = PercentageValueFormatter()

            // 2.2. Second Line Chart Data Entries (Green Line)
            let lineValues2: [Double] = [68, 58, 50, 65, 71]
            var lineEntries2: [ChartDataEntry] = []
            
            for (index, value) in lineValues2.enumerated() {
                let lineEntry = ChartDataEntry(x: Double(index) , y: value)
                lineEntries2.append(lineEntry)
            }
            
            let lineDataSet2 = LineChartDataSet(entries: lineEntries2, label: "Green Line")
            lineDataSet2.colors = [UIColor.green]
            lineDataSet2.circleColors = [UIColor.green]
            lineDataSet2.circleRadius = 10.0
            lineDataSet2.circleHoleRadius = 5.0
            lineDataSet2.valueFont = .systemFont(ofSize: 10)
            lineDataSet2.drawValuesEnabled = true
            lineDataSet2.axisDependency = .right // Ensure it's linked to the right axis
            lineDataSet2.valueFormatter = PercentageValueFormatter()
            
            
            // 3. Create Bar Data Entries for Grey Bars
            let greyBarValues: [Double] = [50, 38, 32, 50, 32]
            var greyBarEntries: [BarChartDataEntry] = []
            
            for (index, value) in greyBarValues.enumerated() {
                let greyBarEntry = BarChartDataEntry(x: Double(index), y: value)
                greyBarEntries.append(greyBarEntry)
            }
            
            let greyBarDataSet = BarChartDataSet(entries: greyBarEntries, label: "Grey Bars")
            greyBarDataSet.colors = [UIColor.gray] // Set the color for the grey bars
            greyBarDataSet.valueFont = .systemFont(ofSize: 10)
            
            // 4. Create Bar Data Entries for Blue Bars
            let blueBarValues: [Double] = [37, 29, 25, 38, 25]
            var blueBarEntries: [BarChartDataEntry] = []
            
            for (index, value) in blueBarValues.enumerated() {
                let blueBarEntry = BarChartDataEntry(x: Double(index), y: value)
                blueBarEntries.append(blueBarEntry)
            }
            
            let blueBarDataSet = BarChartDataSet(entries: blueBarEntries, label: "Blue Bars")
            blueBarDataSet.colors = [UIColor.systemBlue] // Set the color for the blue bars
            blueBarDataSet.valueFont = .systemFont(ofSize: 10)
            
            // 5. Create Combined Chart Data with Line and Bar Data
            let barData = BarChartData(dataSets: [greyBarDataSet, blueBarDataSet])
            let combinedData = CombinedChartData()
            
            combinedData.barData = barData
            combinedData.lineData = LineChartData(dataSets: [lineDataSet1, lineDataSet2])

            // 6. Group Bars Together
            let groupSpace = 0.6 // Space between groups
            let barSpace = 0.055  // Space between bars in the same group
            let barWidth = 0.15  // Width of each bar

            barData.barWidth = barWidth
            barData.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)

            // 7. Set x-axis labels and format
            let xAxis = barChartView.xAxis
            xAxis.valueFormatter = IndexAxisValueFormatter(values: ["2024年1月", "2024年2月", "2024年3月", "2024年4月", "2024年5月"])
            xAxis.labelPosition = .bottom
            xAxis.granularity = 1

            // Calculate the total width of a group
            let groupWidth = barWidth * 2 + barSpace + groupSpace

            // Adjust the x-axis minimum and maximum
            xAxis.axisMinimum = 0// - groupWidth / 2
            xAxis.axisMaximum = Double(blueBarEntries.count) // * groupWidth - groupWidth / 2

            // Center the labels between the bars
            xAxis.centerAxisLabelsEnabled = true

            // Notify the chart that the data has changed
            barChartView.notifyDataSetChanged()

            // 8. Customize the y-axis
            let leftAxis = barChartView.leftAxis
            leftAxis.axisMinimum = 0 // Start y-axis from 0
            leftAxis.granularity = 10
            leftAxis.axisMaximum = 60
            
            // 9. Setup right Axis for line values (0% to 100%)
            let rightAxis = barChartView.rightAxis
            rightAxis.enabled = true // Enable right axis
            rightAxis.axisMinimum = 0 // Minimum value for right axis
            rightAxis.axisMaximum = 110 // Maximum value for right axis
            rightAxis.granularity = 10 // Set granularity for ticks on the right axis
            rightAxis.labelPosition = .outsideChart // Position labels outside
            rightAxis.drawGridLinesEnabled = false // Disable grid lines if not needed
            rightAxis.labelFont = .systemFont(ofSize: 10) // Set font size for right axis labels
            
            // 9. Hide right axis and other chart customizations
            barChartView.rightAxis.enabled = true
            barChartView.legend.enabled = true
            barChartView.chartDescription.enabled = false
            
            // 10. Set the combined data to the chart and refresh
            barChartView.data = combinedData
            barChartView.doubleTapToZoomEnabled = false
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

