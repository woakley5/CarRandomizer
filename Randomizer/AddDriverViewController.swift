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
    @IBOutlet weak var noteField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seatsStepper.minValue = 1
        seatsStepper.maxValue = 100
        seatsStepper.autorepeat = true
        seatsField.delegate = self
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
        self.view.window!.performClose(nil)
    }
    
    @IBAction func clickedStepper(_ sender: Any) {
        seatsField.stringValue = String(seatsStepper.integerValue)
    }
    
    @IBAction func clickedDone(_ sender: Any) {
        let int = seatsField.integerValue
        if int < 1 {
            let alert = NSAlert()
            alert.messageText = "Not enough seats!"
            alert.informativeText = "Please make sure the car has at least 1 seat."
            alert.addButton(withTitle: "OK")
            alert.runModal()
            return
        }
        let driver = Driver(name: nameField.stringValue, seats: int, note: noteField.stringValue)
        AppDelegate.cars.append(driver)
        AppDelegate.reloadSetupTables()
        self.view.window!.performClose(nil)
    }
}

extension AddDriverViewController: NSTextFieldDelegate {
    
    func controlTextDidChange(_ obj: Notification) {
        if (seatsField.integerValue != 0) {
            seatsStepper.integerValue = seatsField.integerValue
        }
    }
    
}
