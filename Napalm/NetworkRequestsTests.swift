//
//  NetworkRequests.swift
//  Napalm
//
//  Created by Mattia Picariello on 03/04/2017.
//  Copyright © 2017 Mattia Picariello. All rights reserved.
//

import Foundation
import UIKit

class NetworkRequestsTests {
    var image: UIImage!
    var email: String
    var id: String
    
    func postData( completion: @escaping (_ results:Any?) -> Void) {
        let Url = "http://playground.iosdeveloperacademy.it/image/upload.php?email=mattiapicariello@icloud.com&id=271"
        
        guard let loanUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: loanUrl)
        request.httpMethod = "POST"
        let imageData: NSData = UIImageJPEGRepresentation(image, 1)! as NSData
        let postString = imageData.base64EncodedString(options: .endLineWithLineFeed)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
        
            //Parse JSON Data
            if let data = data {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                    
                    
                    let message = jsonResult?["success"] as Any
                    
                    DispatchQueue.main.async {
                        completion(message)
                    }
                    
                } catch { print(error) }
            }
        })
        
        task.resume()
    }
    
    func postAddData( completion: @escaping (_ results:Any?) -> Void) {
        let Url = "http://playground.iosdeveloperacademy.it/image/upload.php?email="+email+"&id="+id
        
        guard let loanUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: loanUrl)
        request.httpMethod = "POST"
        let imageData: NSData = UIImageJPEGRepresentation(image, 1)! as NSData
        let postString = imageData.base64EncodedString(options: .endLineWithLineFeed)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            
            //Parse JSON Data
            if let data = data {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                    
                    
                    let message = jsonResult?["success"] as! Bool
                    
                    DispatchQueue.main.async {
                        completion(message)
                    }
                    
                } catch { print(error) }
            }
        })
        
        task.resume()
    }
    
    func addStudent(eMail: String, name: String, surname: String, county: String, country: String){
        var request = URLRequest(url: URL(string: "http://playground.iosdeveloperacademy.it/recipe/recipe.php")!)
        request.httpMethod = "POST"
        
        
        let message =   ["email": eMail, "name": name, "surname": surname,"county":county, "country":country  ] as [String : Any]
        
        
        
        do {
            let data = try JSONSerialization.data(withJSONObject:message, options:[])
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            print(dataString)
            request.httpBody = data
            
            // do other stuff on success
            
        } catch {
            print("JSON serialization failed:  \(error)")
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    init(_ image: UIImage, email: String, id: String){
        self.image = image
        self.email = email
        self.id = id
    }
    
    init(_ image: UIImage){
        self.image = image
        self.email = ""
        self.id = ""
    }
    
}
