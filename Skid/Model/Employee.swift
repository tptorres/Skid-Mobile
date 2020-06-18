//
//  Employee.swift
//  Skid
//
//  Created by Tyler Torres on 4/25/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import Foundation

// Data Model for Employee
struct Employee: Codable {
    let id: Int
    let name: String
    let email: String
    let department: String
    let phone: String
    let skills: [Skill]
}

struct Skill: Codable {
    let skill: String
    let description: String
}


