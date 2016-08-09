//
//  Supporter.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation


class Supporter {
    
    var name: String
    var registrationId: String
    var overdue: Bool
    
    init(name: String, registrationId: String, overdue: Bool) {
        self.name = name
        self.registrationId = registrationId
        self.overdue = overdue
    }
}