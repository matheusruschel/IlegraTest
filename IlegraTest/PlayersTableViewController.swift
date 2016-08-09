//
//  PlayersTableViewController.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

let playerCellIdentifier = "playersCell"

class PlayersTableViewController: UIViewController {
    
    var team: Team?
    @IBOutlet weak var playersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playersTableView.delegate = self
        self.playersTableView.dataSource = self
    }


}
extension PlayersTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let team = team {
            return team.players!.count
        }
        return 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(playerCellIdentifier) as? PlayerTableViewCell
        
        if let team = team {
            cell!.player = team.players![indexPath.row]
        }
        
        
        return cell!
    }
    
    
}
