//
//  PlayerDAO.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

protocol PlayerDAOInterface {
    
    var dbManager: DBManager { get }
    func fetchPlayer(forId playerid: String) -> Player?
    func insertPlayer(player: Player) -> QueryStatus
}

class PlayerDAO: PlayerDAOInterface {
    
    var dbManager: DBManager = DBManager(databaseFilename: dbString)
    
    func fetchPlayer(forId playerid: String) -> Player? {
        
        let query = "select * from player where playerId = \(playerid)"
        
        let playersInfo = self.dbManager.loadDataFromDB(query)
        
        for player in playersInfo {
            let indexName = self.dbManager.arrColumnNames.indexOfObject("name")
            let indexAge = self.dbManager.arrColumnNames.indexOfObject("age")
            let indexsalary = self.dbManager.arrColumnNames.indexOfObject("salary")
            let indexId = self.dbManager.arrColumnNames.indexOfObject("playerId")
            let name = player[indexName] as! String
            let age = Int(player[indexAge] as! String)!
            let salary = Float(player[indexsalary] as! String)!
            let id = player[indexId] as! String
            return Player(playerId:id, name: name, age: age, salary: salary)
            
        }
        
        return nil

    }
    
    func insertPlayer(player: Player) -> QueryStatus {
        
        let query = "insert into player values('\(player.name)',\(player.playerId),\(player.salary),\(player.age))"
        self.dbManager.executeQuery(query)
        
        if self.dbManager.affectedRows != 0 {
            return .Passed
        } else {
            return .Failed(msg:"Could not execute the query.")
        }
    }
    
    
    
}