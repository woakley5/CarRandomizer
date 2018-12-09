//
//  Rider.swift
//  Randomizer
//
//  Created by Will Oakley on 12/7/18.
//  Copyright © 2018 Mobile Developers of Berkeley. All rights reserved.
//

import Foundation

class Rider {
    var name: String
    var driver: Driver?
    
    init(name: String, driver: Driver?) {
        self.name = name
        self.driver = driver
    }
}
