//
//  Team.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

class Team {
    
    var name: String
    var teamId: String
    var players: [Player]?
    var supporters: [Supporter]?
    
    init(name: String,teamId: String, players:[Player]?, supporters:[Supporter]?) {
        self.name = name
        self.teamId = teamId
        self.players = players
        self.supporters = supporters
    }
    
    init(name: String,teamId: String) {
        self.name = name
        self.teamId = teamId
    }

    
    func totalPayroll() -> Float {
        var total: Float = 0.0
        if let players = players {
            for player in players {
                total += player.salary
            }
        }
        
        return total
    }
    
}