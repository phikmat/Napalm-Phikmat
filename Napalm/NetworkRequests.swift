//
//  NetworkRequests.swift
//  Napalm
//
//  Created by Mattia Picariello on 03/04/2017.
//  Copyright © 2017 Mattia Picariello. All rights reserved.
//

import Foundation

class NetworkRequests {
    
    func getData( completion: @escaping (_ results:[Employee]?) -> Void) {
        let Url = "http://playground.iosdeveloperacademy.it/persons/"
        guard let loanUrl = URL(string: Url) else { return }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
        
            //Parse JSON Data
            if let data = data {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                    
                    var employeeList: [Employee] = []
                    
                    let allPersons = jsonResult?["root"] as! [[String:Any]]
                    
                    for singlePerson in allPersons {
                        employeeList.append(Employee(aId: singlePerson["personId"] as! String, aName: singlePerson["personFirst"] as! String, aSurname: singlePerson["personLast"] as! String, aImageUrl: singlePerson["personPictureUrl"] as! String))
                        
                    }
                    
                    DispatchQueue.main.async {
                        completion(employeeList)
                    }
                    
                } catch { print(error) }
            }
        })
        
        task.resume()
    }
}
