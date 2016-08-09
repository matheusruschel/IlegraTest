//
//  TeamsDAO.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

let dbString = "test.sql"

protocol TeamDAOInterface {
    
    var dbManager: DBManager { get }
    func fetchAllTeams() -> [Team]
    func insertTeam(team:Team) -> QueryStatus
}

class TeamsDAO : TeamDAOInterface {
    
    var dbManager: DBManager = DBManager(databaseFilename: dbString)
    var playerDAO: PlayerDAOInterface = PlayerDAO()
    var supporterDAO: SupporterDAOInterface = SuporterDAO()
    
    func fetchAllTeams() -> [Team] {
        
        let query = "select * from teams"
        var queryTeamsPlayers = "select * from teamsplayers where teamId = ?"
        var queryTeamsSupporters = "select * from teamssupporters where teamId = ?"
        
        let teamsInfo = self.dbManager.loadDataFromDB(query)
        
        var teams = [Team]()
        
        let indexTeamName = self.dbManager.arrColumnNames.indexOfObject("name")
        let indexTeamId = self.dbManager.arrColumnNames.indexOfObject("teamId")
        
        for team in teamsInfo {
            let teamName = team[indexTeamName] as! String
            let teamId = team[indexTeamId] as! String
            
            queryTeamsPlayers = "select * from teamsplayers where teamId = \(teamId)"
            
            var players = [Player]()
            
            // query for table with player and team ids
            let teamsPlayersResult = self.dbManager.loadDataFromDB(queryTeamsPlayers)
            
            for teamPlayers in teamsPlayersResult {
                let indexPlayerId = self.dbManager.arrColumnNames.indexOfObject("playerId")
                let playerId = teamPlayers[indexPlayerId] as! String
                players.append(playerDAO.fetchPlayer(forId:playerId )!)
            }
            
            queryTeamsSupporters = "select * from teamssupporters where teamId = \(teamId)"
            
            var supporters = [Supporter]()
            
            let teamsSupportersResult = self.dbManager.loadDataFromDB(queryTeamsSupporters)
            
            // query for table with supporter and team ids
            for teamSupporters in teamsSupportersResult {
                let indexSupporterId = self.dbManager.arrColumnNames.indexOfObject("regId")
                let supporterId = teamSupporters[indexSupporterId] as! String
                supporters.append(supporterDAO.fetchSupporter(forId:supporterId )!)
            }

            
            teams.append(Team(name: teamName,teamId: teamId,players: players,supporters:supporters))
            
        }
        
        
        return teams
    }
    
    func insertTeam(team: Team) -> QueryStatus {
        let queryTeams = "insert into teams values('\(team.name)',\(team.teamId))"
        var queryTeamPlayers = ""
        var queryTeamSupporters = ""
        
        self.dbManager.executeQuery(queryTeams)

        if let players = team.players {
            for player in players {
                
                queryTeamPlayers = "insert into teamsplayers values(\(player.playerId),\(team.teamId))"
                self.dbManager.executeQuery(queryTeamPlayers)
            }
        }
        
        if let supporters = team.supporters {
            for supporter in supporters {
                queryTeamSupporters = "insert into teamssupporters values(\(supporter.registrationId),\(team.teamId))"
                self.dbManager.executeQuery(queryTeamSupporters)
            }
        }
        
        if self.dbManager.affectedRows != 0 {
            return .Passed
        } else {
            return .Failed(msg:"Could not execute the query.")
        }
    }
}
