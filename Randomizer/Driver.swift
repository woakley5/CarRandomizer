//
//  Driver.swift
//  Randomizer
//
//  Created by Will Oakley on 12/7/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Foundation

class Driver: Equatable {
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
    
    static func == (lhs: Driver, rhs: Driver) -> Bool {
        return lhs.name == rhs.name &&
            lhs.note == rhs.note &&
            lhs.seats == rhs.seats &&
            lhs.requiredPassengers == rhs.requiredPassengers &&
            lhs.finalPassengers == rhs.finalPassengers
    }
}

