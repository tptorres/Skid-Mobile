//
//  EmployeeDepartment.swift
//  Skid
//
//  Created by Tyler Torres on 4/28/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

// turn this into a dictionary to prune code for getting correct description
enum Department: String {
    case sales = "The sales department consists of a set of business activities and processes that help a sales organization run effectively, efficiently and in support of business strategies and objectives. "
    case human_resources = "Overseeing current employees and onboarding new employees everyday "
    case engineering = "Driving the technology of the future everyday"
    case finance = "Managing money in the most creative of ways each and every day "
    case quality_assurance = "Making sure the quality of our products is being innovated on and iterated on"
    case operations = "Keeping the workplace in check and applying business decisions of the future"
}

class EmployeeDepartmentVC: UIViewController {
    
    var department: String?
    
    @IBOutlet weak var departmentName: UILabel!
    @IBOutlet weak var departmentDescription: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = department?.capitalized
        // set navigation item name as department name
        
        departmentDescription.text = getDescription(department: department!)
        print(departmentDescription.text!)
        
    }
    
    func getDescription(department: String) -> String {
        switch department {
        case "sales":
            return Department.sales.rawValue
        case "human_resources":
            return Department.human_resources.rawValue
        case "engineering":
            return Department.engineering.rawValue
        case "finance":
            return Department.finance.rawValue
        case "quality_assurance":
            return Department.quality_assurance.rawValue
        case "operations":
            return Department.operations.rawValue
        default:
            return "Department not found"
        }
    }
    
}
