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
    var seats: Int
    var requiredPassengers: [Rider] = []
    var finalPassengers: [Rider] = []
    
    init(name: String, seats: Int) {
        self.name = name
        self.seats = seats
    }
    
    func addRequiredRider(rider: Rider) {
        requiredPassengers.append(rider)
    }
}

