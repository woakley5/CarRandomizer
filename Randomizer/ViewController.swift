//
//  ViewController.swift
//  Randomizer
//
//  Created by Will Oakley on 12/7/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var driversTable: NSTableView!
    @IBOutlet weak var ridersTable: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        driversTable.delegate = self
        driversTable.dataSource = self

        ridersTable.delegate = self
        ridersTable.dataSource = self
        
        driversTable.doubleAction = #selector(removeDriver)
        ridersTable.doubleAction = #selector(removeRider)
    }
    
    @objc func removeDriver() {
        let row = driversTable.clickedRow
        let driver = AppDelegate.cars[row]
        AppDelegate.cars.remove(at: row)
        
        let new = AppDelegate.riders.filter { $0.driver != driver }
        AppDelegate.riders = new
        AppDelegate.reloadSetupTables()
    }
    
    @objc func removeRider() {
        let row = ridersTable.clickedRow
        let rider = AppDelegate.riders[row]
        AppDelegate.riders.remove(at: row)
        
        for d in AppDelegate.cars {
            if d.requiredPassengers.contains(rider) {
                let new = d.requiredPassengers.filter { $0 != rider }
                d.requiredPassengers = new
            }
        }
        
        AppDelegate.reloadSetupTables()
    }
    
    func refreshRidersTable() {
        ridersTable.reloadData()
    }

    @IBAction func clickedAddRider(_ sender: Any) {
        AppDelegate.showRiderWindow()
    }
    
    @IBAction func clickedAddDriver(_ sender: Any) {
        AppDelegate.showDriverWindow()
    }
    
    @IBAction func clickedRandomize(_ sender: Any) {
        var seats = 0
        var overflow: [Driver] = []
        for c in AppDelegate.cars {
            seats += c.seats
            if c.requiredPassengers.count > c.seats {
                overflow.append(c)
            }
        }
        
        if AppDelegate.riders.count == 0 {
            let alert = NSAlert()
            alert.messageText = "No riders!"
            alert.informativeText = "Please add riders before randomizing."
            alert.addButton(withTitle: "OK")
            alert.runModal()
        } else if seats < AppDelegate.riders.count || seats == 0 {
            let alert = NSAlert()
            alert.messageText = "Too many riders!"
            alert.informativeText = "There are more riders than seats. Please add more drivers or remove riders."
            alert.addButton(withTitle: "OK")
            alert.runModal()
        } else if overflow.count > 0 {
            let alert = NSAlert()
            alert.messageText = "Too many passengers!"
            var string = ""
            for o in overflow {
                string.append("> " + o.name + "\n")
            }
            alert.informativeText = "These cars have too many passengers:\n\n" + string + "\nPlease add more seats or edit required passengers."
            alert.addButton(withTitle: "OK")
            alert.runModal()
        } else {
            AppDelegate.randomize()
        }
    }
}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if (tableView == ridersTable) {
            var text: String = ""
            let cellIdentifier: String = "rider1"
            
            if tableColumn == tableView.tableColumns[0] {
                text = AppDelegate.riders[row].name
            } else if tableColumn == tableView.tableColumns[1] {
                if let d = AppDelegate.riders[row].driver {
                    print("Setting text!")
                    text = d.name
                }
            }
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = text
                return cell
            }
            return nil
        } else if (tableView == driversTable) {
            var text: String = "-"
            let cellIdentifier: String = "drivers1"
            
            if tableColumn == tableView.tableColumns[0] {
                text = AppDelegate.cars[row].name
            } else if tableColumn == tableView.tableColumns[1] {
                text = String(AppDelegate.cars[row].seats)
            } else if tableColumn == tableView.tableColumns[2] {
                text = AppDelegate.cars[row].note
            }
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = text
                return cell
            }
            return nil
        }
        return nil
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if (tableView == ridersTable) {
            return AppDelegate.riders.count
        } else if (tableView == driversTable) {
            return AppDelegate.cars.count
        } else {
            return 0
        }
    }

}

