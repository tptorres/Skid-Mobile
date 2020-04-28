//
//  EmployeeInformationVC.swift
//  Skid
//
//  Created by Tyler Torres on 4/28/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class EmployeeInformationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var employee: Employee?
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var departmentEmployees: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // pass into the navigation item title the employees name

    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.text = employee?.email
        
        //tableView.delegate = self
        //tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employee!.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath)
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        return cell
    }
    
    
    // code for sending data to new VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DepartmentInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EmployeeDepartmentVC {
            vc.department = employee?.department
        }
    }
    
}
