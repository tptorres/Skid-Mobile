//
//  EmployeeTableVC.swift
//  Skid
//
//  Created by Tyler Torres on 4/25/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class EmployeeTableVC: UITableViewController {
    
    private lazy var searchBar: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Employees..."
        
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    var employees = [Employee]()
    var filteredEmployees = [Employee]()
    var isSearching = false
    
    var skill_name: String?
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Connect"
        self.navigationItem.searchController = searchBar
        
        self.showSpinner()
        view.addSubview(filterButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(showSkillsVC))
        
        displayEmployeeInformation(skill: skill_name)
    }
    
    func displayEmployeeInformation(skill: String?) {
        
        guard let skill_label = skill else {
            
            print("SYNCH")
            SkidAPIManager.shared.fetchAllEmployees { [weak self] result in
               switch result {
               case .success(let employees):
                self?.employees = employees
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.removeSpinner()
                }
               case .failure(let err):
                   print("Failed request with error:  \(err.localizedDescription)")
               }
            }
            return
        }
        
        SkidAPIManager.shared.fetchSkillEmployees(skillName: skill_label.lowercased()) { [weak self] result in
            switch result {
            case .success(let employees):
                self?.employees = employees
                DispatchQueue.main.async {
                    print("ASYNC")
                    self?.tableView.reloadData()
                    self?.removeSpinner()
                }
           case .failure(let err):
               print("Failed request with error:  \(err.localizedDescription)")
            }
        }
    }
    
    func doSomething(title: String?) {
        guard let test = title else { return }
        print(test)
    }
    
    @objc func showSkillsVC() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredEmployees.count : employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        let employee = isSearching ? filteredEmployees[indexPath.row] : employees[indexPath.row]
        
        cell.setUpCell(for: employee)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEmployeeInfo", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? EmployeeInformationVC {
            nextVC.employee = isSearching ? filteredEmployees[tableView.indexPathForSelectedRow!.row] :                                                employees[tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension EmployeeTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            filteredEmployees = employees.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.tableView.reloadData()
    }
}
