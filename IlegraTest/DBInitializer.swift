//
//  DBInitializer.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/9/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation


// Class used to initialize dummy data
class DBInitializer {

    let teamDAO: TeamDAOInterface = TeamsDAO()
    let playerDAO: PlayerDAOInterface = PlayerDAO()
    let supporterDAO: SupporterDAOInterface = SuporterDAO()
    
     func generateDummyData() {
        
        // BRONCOS
        var player1 = Player(playerId: "1", name: "Nelson", age: 21, salary: 10000.0)
        var player2 = Player(playerId: "2", name: "John", age: 24, salary: 30000.0)
        var player3 = Player(playerId: "3", name: "Cena", age: 19, salary: 20000.0)
        
        let supporter1 = Supporter(name: "BBC", registrationId: "1", overdue: false)
        let supporter2 = Supporter(name: "Sony", registrationId: "2", overdue: false)
        let supporter3 = Supporter(name: "Red Bull", registrationId: "3", overdue: false)
        let supporter4 = Supporter(name: "Microsoft", registrationId: "4", overdue: false)
        let supporter5 = Supporter(name: "Bandai", registrationId: "5", overdue: false)
        let supporter6 = Supporter(name: "Nike", registrationId: "6", overdue: false)
        
        var players = [player1,player2,player3]
        var supporters = [supporter1,supporter2,supporter3,supporter4,supporter5,supporter6]
        
        for player in players {
            playerDAO.insertPlayer(player)
        }
        
        for supporter in supporters {
            supporterDAO.insertSupporter(supporter)
        }
        
        var team = Team(name: "Broncos", teamId: "100", players: players, supporters: supporters)
        
        teamDAO.insertTeam(team)
        
        // PATRIOTS
        player1 = Player(playerId: "4", name: "McGill", age: 21, salary: 10000.0)
        player2 = Player(playerId: "5", name: "Osbourne", age: 24, salary: 30000.0)
        player3 = Player(playerId: "6", name: "Dynamatize", age: 19, salary: 50000.0)
        
        players = [player1,player2,player3]
        
        for player in players {
            playerDAO.insertPlayer(player)
        }
        
        supporters = [supporter1,supporter2]
        
        team = Team(name: "Patriots", teamId: "200", players: players,supporters: supporters)
        
        teamDAO.insertTeam(team)
        
        // HUSKERS
        
        player1 = Player(playerId: "7", name: "Larson", age: 21, salary: 10000.0)
        player2 = Player(playerId: "8", name: "Blazer", age: 24, salary: 30000.0)
        player3 = Player(playerId: "9", name: "Tazer", age: 19, salary: 50000.0)
        
        players = [player1,player2,player3]
        
        for player in players {
            playerDAO.insertPlayer(player)
        }
        
        supporters = [supporter1,supporter4,supporter5,supporter6]
        
        team = Team(name: "Huskers", teamId:"300", players: players,supporters: supporters)

        
        
        teamDAO.insertTeam(team)
        
        
    }
    
}
