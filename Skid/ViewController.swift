//
//  ViewController.swift
//  Skid
//
//  Created by Tyler Torres on 4/24/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    // here in the api manager is where you would put the array of employees grabbed from the api request
    var allEmployees = [Employee]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        fetchEmployees { result in
//            switch result {
//            case .success(let employees):
//                for emp in employees {
//                    if emp.EID == 1 {
//                        print(emp.name)
//                    }
//
//                }
//            case .failure(let err):
//                print("Failed to grab information from the API with error: \(err)")
//            }
//        }
    }
        
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> ()) {
        let url = "https://skid-api.herokuapp.com/api/v1/employees"
        
        guard let urlString = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: urlString) { data, res, error in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            do {
                let employees = try JSONDecoder().decode([Employee].self, from: data!)
                completion(.success(employees))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    
    @IBOutlet weak var dataView: UITextView?
    
    @IBAction func requestData() {
        
        SkidAPIManager.shared.requestEmployee { result in
            switch result {
            // read up a little more on this part of the code
            case .success(let employee):
                print(employee.name)
            case .failure(let err):
                print("Failed request with error:  \(err.localizedDescription)")
            }
        }
    }
    
         
        
      

}

