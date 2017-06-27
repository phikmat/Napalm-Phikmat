//
//  NewViewController.swift
//  Napalm
//
//  Created by Mattia Picariello on 08/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var displayImg: UIImageView!
    var setImage = UIImage()
    var name = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        displayImg.image = setImage
        
        self.navigationController?.navigationBar.backItem?.title = name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
