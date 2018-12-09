//
//  AddRiderViewController.swift
//  Randomizer
//
//  Created by Will Oakley on 12/7/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Cocoa

class AddRiderViewController: NSViewController {

    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var carPicker: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carPicker.removeAllItems()
        var names: [String] = ["-"]
        for d in AppDelegate.cars {
            names.append(d.name)
        }
        carPicker.addItems(withTitles: names)
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
        print("Close!")
        self.view.window!.performClose(nil)
    }
    
    @IBAction func clickedDone(_ sender: Any) {
        let rider: Rider
        if (carPicker.indexOfSelectedItem != 0) {
            let driver = AppDelegate.cars[carPicker.indexOfSelectedItem - 1]
            rider = Rider(name: nameField.stringValue, driver: driver)
            driver.addRequiredRider(rider: rider)
        } else {
            rider = Rider(name: nameField.stringValue, driver: nil)
            AppDelegate.tbdRiders.append(rider)
        }
        AppDelegate.riders.append(rider)
        AppDelegate.reloadSetupTables()
        self.view.window!.performClose(nil)
    }
    
}

