//
//  TeamsTableViewCell.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/8/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var supportersLabel: UILabel!

    @IBOutlet weak var payrollLabel: UILabel!
    
    var team: Team? {
        didSet {
            if let team = team {
                teamNameLabel.text = team.name
                supportersLabel.text = "Supporters: \(team.supporters!.count)"
                payrollLabel.text = "Payroll: $\(team.totalPayroll())"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
