//
//  Rider.swift
//  Randomizer
//
//  Created by Will Oakley on 12/7/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Foundation

class Rider: Equatable {
    var name: String
    var driver: Driver?
    
    init(name: String, driver: Driver?) {
        self.name = name
        self.driver = driver
    }
    
    static func == (lhs: Rider, rhs: Rider) -> Bool {
        return lhs.name == rhs.name &&
            lhs.driver == rhs.driver
    }
}
