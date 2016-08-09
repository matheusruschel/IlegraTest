//
//  SupporterDAO.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

protocol SupporterDAOInterface {
    
    var dbManager: DBManager { get }
    func fetchSupporter(forId supporterid: String) -> Supporter?
    func insertSupporter(supporter: Supporter) -> QueryStatus
}

class SuporterDAO : SupporterDAOInterface {
    
    var dbManager: DBManager = DBManager(databaseFilename: dbString)
    
    func fetchSupporter(forId supporterId: String) -> Supporter? {
        
        let query = "select * from supporter where registrationId = \(supporterId)"
        
        let supportersInfo = self.dbManager.loadDataFromDB(query)
        
        for supporter in supportersInfo {
            let indexName = self.dbManager.arrColumnNames.indexOfObject("name")
            let indexRegId = self.dbManager.arrColumnNames.indexOfObject("registrationId")
            let indexOverdue = self.dbManager.arrColumnNames.indexOfObject("overdue")
            let name = supporter[indexName] as! String
            let regId = supporter[indexRegId] as! String
            let overdue = Bool(Int(supporter[indexOverdue] as! String)!)
            return Supporter(name: name, registrationId: regId, overdue: overdue)
            
        }
        
        return nil
        
    }
    
    func insertSupporter(supporter: Supporter) -> QueryStatus {
        
        let query = "insert into supporter values('\(supporter.name)',\(supporter.registrationId),\(Int(supporter.overdue)))"
        self.dbManager.executeQuery(query)
        
        if self.dbManager.affectedRows != 0 {
            return .Passed
        } else {
            return .Failed(msg:"Could not execute the query.")
        }
    }


}