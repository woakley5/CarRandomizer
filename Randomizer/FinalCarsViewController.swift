//
//  FinalCarsViewController.swift
//  Randomizer
//
//  Created by Will Oakley on 12/8/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Cocoa
import Quartz

class FinalCarsViewController: NSViewController {
    
    @IBOutlet weak var carsTableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carsTableView.delegate = self
        carsTableView.dataSource = self
        removeAllTableColumn()
        
        for (i, x) in AppDelegate.cars.enumerated() {
            let col = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "\(i)"))
            col.title = x.name
            col.width = view.frame.width / CGFloat(AppDelegate.cars.count)
            carsTableView.addTableColumn(col)
        }
        carsTableView.reloadData()
    }
    
    func removeAllTableColumn()
    {
        let tColCount = carsTableView.tableColumns.count
        var i = 0
        while i < tColCount && tColCount > 0{
            carsTableView.removeTableColumn((carsTableView.tableColumns[0]))
            i += 1
        }
    }
    
    @IBAction func clickedExport(_ sender: Any) {
        let pdfData = view.dataWithPDF(inside: carsTableView.bounds)
        let savePanel = NSSavePanel()
        savePanel.title = "Save PDF"
        savePanel.allowedFileTypes = ["pdf"]
        savePanel.beginSheetModal(for: self.view.window!) { (response) in
            do {
                try pdfData.write(to: savePanel.url!)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension FinalCarsViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        var max = 0
        for car in AppDelegate.cars {
            if car.finalPassengers.count > max {
                max = car.finalPassengers.count
            }
        }
        print(max)
        return max
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text = ""
        let cellIdentifier: String = "car1"
        let colIndex = tableView.tableColumns.firstIndex(of: tableColumn!)!
        
        let car = AppDelegate.cars[colIndex]
        
        if (row < car.finalPassengers.count) {
            text = car.finalPassengers[row].name
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}
