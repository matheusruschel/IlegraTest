//
//  PlayerTableViewCell.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/9/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    var player: Player? {
        didSet {
            if let player = player {
                nameLabel.text = player.name
                payrollLabel.text = "Salary: $\(player.salary)"
                ageLabel.text = "Age: \(player.age)"
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var payrollLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
