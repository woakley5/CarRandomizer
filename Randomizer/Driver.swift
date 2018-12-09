//
//  Driver.swift
//  Randomizer
//
//  Created by Will Oakley on 12/7/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Foundation

class Driver {
    var name: String
    var note: String
    var seats: Int
    var requiredPassengers: [Rider] = []
    var finalPassengers: [Rider] = []
    
    init(name: String, seats: Int, note: String) {
        self.name = name
        self.seats = seats
        self.note = note
    }
    
    func addRequiredRider(rider: Rider) {
        requiredPassengers.append(rider)
    }
}

