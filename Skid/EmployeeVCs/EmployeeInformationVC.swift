//
//  EmployeeInformationVC.swift
//  Skid
//
//  Created by Tyler Torres on 4/28/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit
import AVFoundation

class EmployeeInformationVC: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var departmentButton: UIButton!
    @IBOutlet weak var transition: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = employee?.name
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.22, green: 0.70, blue: 0.8, alpha: 1.00)
        self.navigationController?.navigationBar.barTintColor = .white

               
        var formattedPhone = employee!.phone
        formattedPhone.insert("-", at: (formattedPhone.index(formattedPhone.startIndex, offsetBy: 3)))
        formattedPhone.insert("-", at: (formattedPhone.index(formattedPhone.startIndex, offsetBy: 7)))
        
        email.text = employee?.email
        phone.text = formattedPhone
        profilePic.image = UIImage(named: employee!.name)
        department.text = employee?.department.checkAndSplit()
        
        transition.translatesAutoresizingMaskIntoConstraints = false
        transition.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        transition.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        transition.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        transition.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        departmentButton.isUserInteractionEnabled = false
        departmentButton.layer.shadowColor = UIColor.black.cgColor
        departmentButton.layer.shadowOpacity = 0.5
        departmentButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        departmentButton.layer.shadowRadius = 2.5
        
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        profilePic.clipsToBounds = true
        
        containerView.layer.borderWidth = 0.3
        containerView.layer.borderColor = UIColor.black.cgColor
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        let alert = UIAlertController(title: "Add To Favorites?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in

            let defaults = UserDefaults.standard
            guard let employee = self.employee else { return }
            
            if let data = defaults.data(forKey: "favorites") {
                do {
                    var favs = try JSONDecoder().decode([Employee].self, from: data)
                    
                    let res = favs.filter { $0.id == self.employee?.id }
                    if !res.isEmpty && !favs.isEmpty {
                        self.enableAnimation(willAdd: false)
                        return
                    }
                    
                    favs.append(employee)
                    let newFavs = try JSONEncoder().encode(favs)
                    defaults.set(newFavs, forKey: "favorites")
                } catch {
                    print("Unable to decode and update favorites array")
                }
            } else {
                let newFavs = [employee]
                do {
                    let favs = try JSONEncoder().encode(newFavs)
                    defaults.set(favs, forKey: "favorites")
                } catch  {
                    print("Unable to encode favorites array")
                }
            }
            UIDevice.playSoundOnFavorite()
            self.enableAnimation(willAdd: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func enableAnimation(willAdd: Bool) {
        let text = willAdd ? "\(employee!.name) was added to favorites!" : "Already in favorites!"
        
        let favoritedView = UIView()
        favoritedView.alpha = 1
        favoritedView.backgroundColor = UIColor(red: 0.22, green: 0.70, blue: 0.8, alpha: 1.00)
        favoritedView.frame = CGRect(x: 100, y: 350, width: 200, height: 100)
        favoritedView.layer.cornerRadius = 10
        favoritedView.center = view.center
        favoritedView.layer.shadowOpacity = 1
        favoritedView.layer.shadowOffset = .zero
        favoritedView.layer.shadowRadius = 5
        view.addSubview(favoritedView)
        
        let favLabel = UILabel()
        favLabel.frame = favoritedView.bounds
        favLabel.text = text
        favLabel.textColor = UIColor.white
        favLabel.textAlignment = .center
        favLabel.numberOfLines = 0
        favoritedView.addSubview(favLabel)
        
        UIView.animate(withDuration: 4) {
            favoritedView.alpha = 0
        }
    }
    
    @IBAction func showDepartmentEmployees () {
        performSegue(withIdentifier: "department", sender: self)
    }
}

extension EmployeeInformationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (employee?.skills.count)!
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SkillCell
        let skill = employee?.skills[indexPath.row]
        
        cell.setCell(cellInfo: skill!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? EmployeeDepartmentVC {
            nextVC.department = employee?.department
        }
    }
}

