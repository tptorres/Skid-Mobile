//
//  SkidAPIManager.swift
//  Skid
//
//  Created by Tyler Torres on 4/25/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import Foundation

class SkidAPIManager {
    
    static let shared = SkidAPIManager()
    
    let baseUrl = "https://skid-api.herokuapp.com/api/v1/employees"
    let departmentUrl = "/department"
    
    func fetchSingleEmployee(employeeId: Int, completionHandler: @escaping (Result<Employee, Error>) -> ()) {
        let urlString = baseUrl + "/" + String(employeeId)
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                completionHandler(.failure(err))
                return
            }
            guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            
            do {
                let employee = try JSONDecoder().decode(Employee.self, from: data!)
                completionHandler(.success(employee))
            } catch let jsonError {
                completionHandler(.failure(jsonError))
            }
        }.resume()
    }
    
    func fetchAllEmployees(completionHandler: @escaping (Result<[Employee], Error>) -> ()) {
        let urlString = baseUrl
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                completionHandler(.failure(err))
                return
            }
            guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            
            do {
                let employees = try JSONDecoder().decode([Employee].self, from: data!)
                completionHandler(.success(employees))
            } catch let jsonError {
                completionHandler(.failure(jsonError))
            }
        }.resume()
    }
    
    func fetchDepartmentEmployees(departmentName: String, completionHandler: @escaping (Result<[Employee], Error>) -> ()) {
        
        let urlString = baseUrl + departmentUrl + "?name=\(departmentName)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            
            if let err = err {
                completionHandler(.failure(err))
                return
            }
            guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            
            do {
                let employees = try JSONDecoder().decode([Employee].self, from: data!)
                completionHandler(.success(employees))
            } catch let jsonError {
                completionHandler(.failure(jsonError))
            }
        }.resume()
    }
    
    func fetchSkillEmployees(skillName: String, completionHandler: @escaping (Result<[Employee], Error>) -> ()) {
        
        var skillName = skillName
        if skillName == "public" {
            skillName = "public_speaking"
        }
        
        let urlString = baseUrl + "/skill?name=\(skillName)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            
            if let err = err {
                completionHandler(.failure(err))
                return
            }
            guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            
            do {
                let employees = try JSONDecoder().decode([Employee].self, from: data!)
                //print(employees)
                completionHandler(.success(employees))
            } catch let jsonError {
                completionHandler(.failure(jsonError))
            }
        }.resume()
    }
}
