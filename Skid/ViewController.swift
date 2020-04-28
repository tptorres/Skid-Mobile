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
    var firstEmployee: Employee?

    override func viewDidLoad() {
        super.viewDidLoad()
        getEmployee()
        
    
    }
    
    func getEmployee() {
        SkidAPIManager.shared.fetchSingleEmployee(employeeId: 1) { result in
           switch result {
           // read up a little more on this part of the code
           case .success(let employee):
           print("TES")
            
           case .failure(let err):
               print("Failed request with error:  \(err.localizedDescription)")
           }
        }
    }

}

