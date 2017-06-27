//
//  ViewControllerDetail.swift
//  Napalm
//
//  Created by Mattia Picariello on 07/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import UIKit

class ViewControllerAdder: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var employee = Employee()
    

    @IBOutlet var nameField: UITextField!
    @IBOutlet var surnameField: UITextField!
    @IBOutlet var idField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var addImageButton: UIButton!
    @IBOutlet var imageEmployeeView: UIImageView!
    @IBOutlet var roleIconImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        functions.setBorderRadiusImageView(imageView: self.imageEmployeeView)
    }
    
    func imagePressed()
    {
        //do  Your action here  whatever you want
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
        
        secondViewController.setImage = employee.getImage()
        secondViewController.name = employee.getName()
        secondViewController.navigationItem.title = employee.getName() + " " + employee.getSurname()
        
        self.navigationController!.pushViewController(secondViewController, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageEmployeeView.image = employee.getImage()
        self.roleIconImage.image = employee.getRoleIcon()
        
        let tapGesture = UITapGestureRecognizer(target:self, action:#selector(ViewControllerDetail.imagePressed))
        self.imageEmployeeView.isUserInteractionEnabled = true // this line is important
        self.imageEmployeeView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addImageButtonDidPressed(_ sender: Any) {
        selectPhoto()
    }
    
    @IBAction func cancelButtonDidPressed(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonDidPressed(_ sender: Any) {
        //Invio i dati al database con una pop
        let postRequest = NetworkRequestsTests(functions.resizeImage(image: employee.getImage(), newWidth: 1000), email: emailField.text!, id: idField.text!)
        postRequest.postAddData(completion: { (message) in
            
            DispatchQueue.main.async {
                print(message as! Bool)
            }
        })
        
        _ = navigationController?.popViewController(animated: true)
        //EmployeeDetails
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "EmployeeDetails") as! ViewControllerDetail
        secondViewController.employee = employee
        self.navigationController!.pushViewController(secondViewController, animated: false)
    }
    
    func selectPhoto() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            
            imageEmployeeView.image = functions.resizeImage(image: image, newWidth: imageEmployeeView.bounds.size.width)
            employee.setImage(aImage: functions.resizeImage(image: image, newWidth: 1000))
        }
        else
        {
            //Error message
        }
        
        
        picker.dismiss(animated: true, completion: nil)
        
        //self.tabBarController?.selectedIndex = 0
        //        let svc = self.storyboard!.instantiateViewController(withIdentifier: "profileID")
        //        self.present(svc, animated: false, completion: nil)
        
        
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
