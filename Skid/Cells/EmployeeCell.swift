//
//  EmployeeCell.swift
//  Skid
//
//  Created by Tyler Torres on 4/25/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
        
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var skill1: UIButton!
    @IBOutlet weak var skill2: UIButton!
    
    func setUpCell(for employee: Employee) {
        profilePicture.image = UIImage(named: employee.name)
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
        profilePicture.clipsToBounds = true
        
        skill1.setSkillsButton()
        skill1.setTitle(employee.skills[0].skill.checkAndSplit(), for: .normal)
        skill2.setSkillsButton()
        skill2.setTitle(employee.skills[1].skill.checkAndSplit(), for: .normal)
        
        name.text = employee.name  
    }
}
