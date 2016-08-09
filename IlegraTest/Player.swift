//
//  Player.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

class Player {
    
    var name: String
    var age: Int
    var salary: Float
    var playerId: String
    
    init(playerId: String, name: String, age: Int, salary: Float) {
        self.name = name
        self.age = age
        self.salary = salary
        self.playerId = playerId
    }
}