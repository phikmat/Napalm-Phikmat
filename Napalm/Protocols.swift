//
//  Protocols.swift
//  Napalm
//
//  Created by Mattia Picariello on 12/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import Foundation
import UIKit

protocol EmployeeManagerDelegate{
    func dataManipulaqtionFinished(employees: [Employee])
    func dataImageManipulaqtionFinished(id: Int, image: UIImage)
}

final class Singleton{
    
    static let sharedInstance = Singleton()
    var delegate: EmployeeManagerDelegate?
    
    
    var employees: [Employee] = []
    
    private init(){
        employees = []
        getEmployeesSomehow()
    }
    
    func getEmployeesSomehow(){
        //GET DATA
        let getRequest = NetworkRequests()
        getRequest.getData(completion: { (myEmployeeList) in
            
            var index = 0
            DispatchQueue.global(qos: .userInteractive).async {
                self.employees = myEmployeeList!
                self.delegate?.dataManipulaqtionFinished(employees: self.employees)
                for employee in self.employees{
                    employee.loadImage(completion: { (employeeImage) in
                        DispatchQueue.main.async {
                            print(index)
                            employee.setImage(aImage: employeeImage as! UIImage)
                            self.delegate?.dataImageManipulaqtionFinished(id: index, image: employeeImage as! UIImage)
                            index += 1
                        }
                    })
                }
            }
        })
    }
}
