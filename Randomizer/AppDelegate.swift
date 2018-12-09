//
//  AppDelegate.swift
//  Randomizer
//
//  Created by Will Oakley on 12/7/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    static var cars: [Driver] = []
    static var tbdRiders: [Rider] = []
    static var riders: [Rider] = []
    
    static var editPeopleView: ViewController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let editPeopleWindow = NSStoryboard(name: "Main", bundle: Bundle.main).instantiateController(withIdentifier: "editPeopleViewController") as! NSWindowController
        AppDelegate.editPeopleView = editPeopleWindow.contentViewController as! ViewController
        editPeopleWindow.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    static func showDriverWindow() {
        let myWindowController = NSStoryboard(name: "Main", bundle: Bundle.main).instantiateController(withIdentifier: "addDriverWindow") as! NSWindowController
        myWindowController.showWindow(self)
    }
    
    static func showRiderWindow() {
        let myWindowController = NSStoryboard(name: "Main", bundle: Bundle.main).instantiateController(withIdentifier: "addRiderWindow") as! NSWindowController
        myWindowController.showWindow(self)
    }
    
    static func showFinalWindow() {
        let myWindowController = NSStoryboard(name: "Main", bundle: Bundle.main).instantiateController(withIdentifier: "generatedWindow") as! NSWindowController
        myWindowController.showWindow(self)
    }
    
    static func reloadSetupTables() {
        editPeopleView.driversTable.reloadData()
        editPeopleView.ridersTable.reloadData()
    }
    
    static func randomize() {
        cars.shuffle()
        riders.shuffle()
        tbdRiders.shuffle()
        
        var index = 0
        
        for car in cars {
            car.finalPassengers.removeAll()
            car.finalPassengers.append(contentsOf: car.requiredPassengers)
            while car.finalPassengers.count < car.seats && index < tbdRiders.count {
                car.finalPassengers.append(tbdRiders[index])
                index += 1
            }
        }
        showFinalWindow()
    }
    
    

}

