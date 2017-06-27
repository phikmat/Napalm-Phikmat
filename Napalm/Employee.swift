//
//  Employee.swift
//  Napalm
//
//  Created by Mattia Picariello on 03/04/2017.
//  Copyright © 2017 Mattia Picariello. All rights reserved.
//

import Foundation
import UIKit

class Employee {
    
    //Attributes
    var name: String
    var surname: String
    var role: String
    var roleIcon: UIImage
    var id: String
    var nId: Int
    var image: UIImage?
    var urlImage: String
    //var indice: Int
    
    //Init
    init(aId: String, aName: String, aSurname: String, aImageUrl: String) {
        id = aId;
        nId = Int(id)!
        name = aName
        surname = aSurname
        
        role = "Role"
        let roles = EmployeeRole(role)
        roleIcon = roles.icon

        urlImage = aImageUrl
        image = nil
        
    }
    
    init(){
        id = "ID Number"
        nId = 0
        name = "Name"
        surname = "Surname"
        role = "Role"
        let roles = EmployeeRole(role)
        roleIcon = roles.icon
        urlImage = "URL"
        image = UIImage(named: "default-user-image")
    }

    
    //Getters and Setters
    func getName() -> String {
        return self.name
    }
    
    func getSurname() -> String {
        return self.surname
    }
    
    func getRole() -> String {
        return self.role
    }
    
    func getRoleIcon() -> UIImage {
        return self.roleIcon
    }
    
    func getID() -> String {
        return self.id
    }
    
    func getImage() -> UIImage {
        return self.image!
    }
    
    func getUrlImage() -> String {
        return self.urlImage
    }
    
    func setName(aName: String){
        self.name = aName
    }
    
    func setSurname(aSurname: String){
        self.surname = aSurname
    }
    
    func setRole(aRole: String){
        self.role = aRole
        setRoleIcon(aRole: aRole)
    }
    
    func setRoleIcon(aRole: String){
        let roles = EmployeeRole(aRole)
        self.roleIcon = roles.icon
    }
    
    func setID(aID: String){
        self.id = aID
    }
    
    func setImage(aImage: UIImage){
        self.image = aImage
    }
    
    func setUrlImage(aUrl: String){
        self.urlImage = aUrl
    }
    
    func loadImage( completion: @escaping (_ results:Any?) -> Void) {
        let urlString:String = self.urlImage
        if urlString.isEmpty {
            let image = UIImage(named: "default-user-image")!
            completion(image)
        } else {
            let catPictureURL = URL(string: urlString)!
            let session = URLSession(configuration: .default)
            
            let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
                if let e = error {
                    print("Error downloading cat picture: \(e)")
                } else {
                    // No errors found.
                    if let res = response as? HTTPURLResponse {
                        if let imageData = data {
                            
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)!
                                completion(image)
                            }
                        }
                    }
                }
            }
            
            downloadPicTask.resume()
        }
        
    }
}
