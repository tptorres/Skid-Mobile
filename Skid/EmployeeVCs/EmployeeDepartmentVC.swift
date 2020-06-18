//
//  EmployeeDepartment.swift
//  Skid
//
//  Created by Tyler Torres on 4/28/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class EmployeeDepartmentVC: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var departmentButton: UIButton!
    
    var departmentDict: [String: String] = ["sales": "The sales department consists of a set of business activities and processes that help a sales organization run effectively, efficiently and in support of business strategies and objectives.", "human_resources": "Overseeing current employees and onboarding new employees everyday.", "engineering": "Driving the technology of the future everyday.", "finance": "Managing money in the most creative of ways each and every day.", "quality_assurance": "Making sure the quality of our products is being innovated on and iterated on.", "operations":"Keeping the workplace in check and applying business decisions of the future." ]
    
    var department: String?
    var deptEmployees = [Employee]() 
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = department?.checkAndSplit()
        self.navigationController?.navigationBar.barTintColor = .white

        
        descriptionLabel.text = departmentDict[department!]
        descriptionLabel.numberOfLines = 0
        descriptionLabel.addLineSpacing(spaceValue: 3)
        
        departmentButton.isUserInteractionEnabled = false
        departmentButton.layer.shadowColor = UIColor.black.cgColor
        departmentButton.layer.shadowOpacity = 0.5
        departmentButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        departmentButton.layer.shadowRadius = 2.5
        
        containerView.layer.borderWidth = 0.3
        containerView.layer.borderColor = UIColor.black.cgColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        print(department)
        
        fetchEmployees(department: department!)
    }
    
    func fetchEmployees(department: String) {
        SkidAPIManager.shared.fetchDepartmentEmployees(departmentName: department) { [weak self] result in
            switch result {
            case .success(let employees):
                self?.deptEmployees = employees
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

extension EmployeeDepartmentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deptEmployees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeListCell") as! EmployeeCell
        let employee = deptEmployees[indexPath.row]
    
        cell.setUpCell(for: employee)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "departmentEmployee", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? EmployeeInformationVC {
            nextVC.employee = deptEmployees[tableView.indexPathForSelectedRow!.row]
        }
    }
}
