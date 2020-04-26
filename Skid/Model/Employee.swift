//
//  Employee.swift
//  Skid
//
//  Created by Tyler Torres on 4/25/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import Foundation

// Data Model for Employee
struct Employee: Decodable {
    let EID: Int
    let name: String
    //let skills: [Skills]
    let email: String
    let department: String
    let phone: String
}

struct Skills: Decodable {
    let skill: String
    let description: String
}


