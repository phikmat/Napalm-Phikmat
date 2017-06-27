//
//  EmployeeRole.swift
//  Napalm
//
//  Created by Mattia Picariello on 07/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import Foundation
import UIKit

struct EmployeesRoles {
    let designer: String = "Designer"
    let developer: String = "Developer"
    let chef: String = "Chef"
    let manager: String = "Manager"
    let lawyer: String = "Lawyer"
    let marketer: String = "Markter"
    let customerSupport: String = "Customer Suppert"
}

class EmployeeRole {
    let employeersRoles = EmployeesRoles()
    let icon:UIImage
    
    init(_ role: String){
        switch role {
        case employeersRoles.designer:
            self.icon = UIImage(named: role)!
        case employeersRoles.developer:
            self.icon = UIImage(named: role)!
        case employeersRoles.chef:
            self.icon = UIImage(named: role)!
        case employeersRoles.manager:
            self.icon = UIImage(named: role)!
        case employeersRoles.lawyer:
            self.icon = UIImage(named: role)!
        case employeersRoles.marketer:
            self.icon = UIImage(named: role)!
        case employeersRoles.customerSupport:
            self.icon = UIImage(named: role)!
        default:
            self.icon = UIImage(named: "Employeer")!
        }
    }
}
