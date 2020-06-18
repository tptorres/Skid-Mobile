//
//  EmployeeFavoritesVC.swift
//  Skid
//
//  Created by Tyler Torres on 4/28/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class EmployeeFavoritesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var employees = [Employee]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.barTintColor = .white

        
        fetchFavsFromDefaults()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavsFromDefaults()
    }
    
    func fetchFavsFromDefaults() {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "favorites") {
            do {
                self.employees = try JSONDecoder().decode([Employee].self, from: data)
            } catch {
                print("Favs could not be fetched")
            }
        }
    }
}

extension EmployeeFavoritesVC: FavoriteCellDelegate {
    
    func didTapDelete(id: Int) {
        let alert = UIAlertController(title: "Confirm Delete", message: "Delete", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { action in
            
            let updatedEmployees = self.employees.filter { $0.id != id }
            self.employees = updatedEmployees
            
            let defaults = UserDefaults.standard
            if let data = defaults.data(forKey: "favorites") {
                do {
                    var favs = try JSONDecoder().decode([Employee].self, from: data)
                    favs = self.employees
                    
                    let newFavs = try JSONEncoder().encode(favs)
                    defaults.set(newFavs, forKey: "favorites")
                } catch {
                    print("Unable to decode and update favorites array")
                }
            }
        })
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension EmployeeFavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavoriteCell
        let employee = employees[indexPath.row]
        
        cell.delegate = self
        cell.setUpCell(for: employee)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favToInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? EmployeeInformationVC {
            nextVC.employee = employees[tableView.indexPathForSelectedRow!.row]
        }
    }
}


