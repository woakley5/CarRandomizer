//
//  AddDriverViewController.swift
//  Randomizer
//
//  Created by Will Oakley on 12/7/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Cocoa

class AddDriverViewController: NSViewController {

    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var seatsField: NSTextField!
    @IBOutlet weak var seatsStepper: NSStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
        self.view.window!.performClose(nil)
    }
    
    @IBAction func clickedDone(_ sender: Any) {
        let int = seatsField.integerValue
        let driver = Driver(name: nameField.stringValue, seats: int)
        AppDelegate.cars.append(driver)
        AppDelegate.reloadSetupTables()
        self.view.window!.performClose(nil)
    }
}

