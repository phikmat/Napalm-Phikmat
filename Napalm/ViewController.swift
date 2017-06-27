//
//  ViewController.swift
//  Napalm
//
//  Created by Mattia Picariello on 07/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendButtonDidPressed(_ sender: Any) {
        if self.emailText.text != ""{
            
            /*
            let postRequest = NetworkRequestsTests(self.emailText.text!)
            postRequest.postData(completion: { (message) in
                
                DispatchQueue.main.async {
                    self.myLabel.text = message
                }
            })
 */
            
            self.emailText.text = ""
            
        } else {
            self.myLabel.text = "Missing Email"
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
