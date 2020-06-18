//
//  SkillCell.swift
//  Skid
//
//  Created by Tyler Torres on 5/3/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell {

    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func setCell(cellInfo: Skill) {
        skillLabel.text = cellInfo.skill.checkAndSplit()
        
        if skillLabel.text!.contains(" ") {
            skillLabel.numberOfLines = 2
        } else {
            skillLabel.numberOfLines = 1
        }
        
        descLabel.text = cellInfo.description
        descLabel.numberOfLines = 0
        descLabel.addLineSpacing(spaceValue: 2)
    }
}
