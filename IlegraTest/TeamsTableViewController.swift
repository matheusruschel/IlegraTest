//
//  TeamsTableViewController.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

let cellIdentifier = "TeamCell"
let playerSegueIdentifier = "playersVCSegue"

enum Filter {
    case Supporter
    case Payroll
    case SupAndPay
}

class TeamsTableViewController: UIViewController {
    
    @IBOutlet weak var teamsTableView: UITableView!
    var alertController : UIAlertController!
    var teamDAO: TeamDAOInterface!
    var teams: [Team]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamsTableView.delegate = self
        self.teamsTableView.dataSource = self

        configureAlertController()
        let barButtonItemFilter = UIBarButtonItem(title: "Filter", style: .Done, target: self, action: #selector(showFilterMenu))
        self.navigationItem.rightBarButtonItem = barButtonItemFilter
        
        self.teamDAO = TeamsDAO()
        teams = self.teamDAO.fetchAllTeams()
        self.filterTeam(by: .Supporter)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == playerSegueIdentifier {
            
            let destVc = segue.destinationViewController as! PlayersTableViewController
            let cell = sender as! TeamsTableViewCell
            
            destVc.team = cell.team
        }
    }
    
    // MARK: Button Action show filter menu
    
    func showFilterMenu() {
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: Configuring Alert Controller
    
    func configureAlertController() {
        
        alertController = UIAlertController(title: "Filter", message: "How would you like to order the teams?", preferredStyle: .ActionSheet)
        let alertActionFilterBySupporters = UIAlertAction(title: "Supporters", style: .Default, handler: {action in
        
            self.filterTeam(by: .Supporter)
        })
        
        let alertActionFilterByPayroll = UIAlertAction(title: "Payroll", style: .Default, handler: {action in
            
            self.filterTeam(by: .Payroll)
        })
        
        let alertActionFilterByBoth = UIAlertAction(title: "Supporters & Payroll", style: .Default, handler: {action in
            
            self.filterTeam(by: .SupAndPay)
        })
        
        
        alertController.addAction(alertActionFilterBySupporters)
        alertController.addAction(alertActionFilterByPayroll)
        alertController.addAction(alertActionFilterByBoth)
        
    }
    
    // MARK : ORDERING FILTER
    
    func filterTeam(by filter:Filter) {
        
        switch filter {
        case .Supporter:
            self.teams!.sortInPlace({ $0.supporters!.count > $1.supporters!.count})
        case .Payroll:
            self.teams!.sortInPlace({ $0.totalPayroll() > $1.totalPayroll()})
        case .SupAndPay:
            self.teams!.sortInPlace({t1,t2 in // priority is payroll, if it's equal then solve by supporter amount
                
                if t1.totalPayroll() > t2.totalPayroll() {
                    return true
                }
                
                if t2.supporters!.count > t1.supporters!.count {
                    return false
                }
                
                // solve by supporter amount
                if t1.totalPayroll() == t2.totalPayroll() {
                    return t1.supporters!.count > t2.supporters!.count
                }
                
                return false
                
                })
        }
        self.teamsTableView.reloadData()
    }
    

}
extension TeamsTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! TeamsTableViewCell
        
        cell.team = teams[indexPath.row]
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        self.performSegueWithIdentifier(playerSegueIdentifier, sender: cell)
    }
    
}

