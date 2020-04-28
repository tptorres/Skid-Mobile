//
//  EmployeeTableVC.swift
//  Skid
//
//  Created by Tyler Torres on 4/25/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class EmployeeTableVC: UITableViewController {
    
    var employees = [Employee]()

    override func viewDidLoad() {
        super.viewDidLoad()
        displayEmployeeInformation()
    }
    
    
    // TODO: maybe for later add an activity indicator until the data is fetched and displayed
    func displayEmployeeInformation() -> Void {
        SkidAPIManager.shared.fetchAllEmployees { [weak self] result in
           switch result {
           // read up a little more on this part of the code
           case .success(let employees):
            self?.employees = employees
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
           case .failure(let err):
               print("Failed request with error:  \(err.localizedDescription)")
           }
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeListCell", for: indexPath) as! EmployeeCell
        
        let ecell = employees[indexPath.row]
        
        cell.email.text = ecell.email
        cell.name.text = ecell.name
        cell.skill1.text = ecell.skills[0].skill
        cell.skill2.text = "Test"
    
        return cell
    }
    
    // this will tell the view controlller to switch to the new VC that has the segue with that identifier
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEmployeeInfo", sender: self)
    }
    
    // The destination property on segue has type UIViewController, so you’ll need to cast it to get to the employee property.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EmployeeInformationVC {
            destination.employee = employees[tableView.indexPathForSelectedRow!.row]
        }
    }
    

    
    
    
    

}
