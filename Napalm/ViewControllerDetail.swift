//
//  ViewControllerDetail.swift
//  Napalm
//
//  Created by Mattia Picariello on 07/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import UIKit
import MapKit

class ViewControllerDetail: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var employee = Employee()
    var currentPlacemark : CLPlacemark?
    var currentRoute: MKRoute?
    let manager = CLLocationManager()
    

    @IBOutlet var addressMap: MKMapView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var surnameLabe: UILabel!
    @IBOutlet var idNumberLabel: UILabel!
    @IBOutlet var addImageButton: UIButton!
    @IBOutlet var imageEmployeeView: UIImageView!
    @IBOutlet var roleIconImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressMap.delegate = self
        addressMap.showsScale = true
        addressMap.showsCompass = true
        
        
        addAPin()
        
        

        functions.setBorderRadiusImageView(imageView: self.imageEmployeeView)
    }
    
    @IBAction func goButtonDidPressed(_ sender: Any) {
        
        addressToCoordinatesConverter(address: "Via Alcide De Gasperi, 50, 80046")
    }
    
    func addressToCoordinatesConverter(address: String) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            
            // Use your location
            self.openMapForPlace(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, name: address)
        }
    }
    
    func openMapForPlace(latitude: CLLocationDegrees, longitude: CLLocationDegrees, name: String) {
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
    
    func addAPin() {
        
        let addressToPin = CLGeocoder()
        addressToPin.geocodeAddressString("Via Alcide De Gasperi, 50, San Giorgio a Cremano") { (placemarks, error) in
            if (error != nil){
                print ("there was an error")
            }
            
            
            if let placemarks = placemarks {
                let myPlc = placemarks[0]
                let annotationToAdd = MKPointAnnotation()
                
                annotationToAdd.title = "Via Alcide De Gasperi"
                annotationToAdd.subtitle = "My Place Subtitle!"
                annotationToAdd.coordinate = (myPlc.location?.coordinate)!
                
                self.addressMap.showAnnotations([annotationToAdd], animated: true)
                
                
            }
            
        }
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        
        var AnnotationView : MKPinAnnotationView? = self.addressMap.dequeueReusableAnnotationView(withIdentifier: "myPin") as? MKPinAnnotationView
        
        if AnnotationView == nil {
            AnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            AnnotationView?.canShowCallout = true
            AnnotationView?.rightCalloutAccessoryView = UIButton(type:
                UIButtonType.detailDisclosure)
            AnnotationView?.pinTintColor = UIColor.blue
        }
        
        
        
        let leftImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        leftImage.image = UIImage(named: "street")
        AnnotationView?.leftCalloutAccessoryView = leftImage
        
        
        return AnnotationView
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
        self.nameLabel.text = employee.getName()
        self.surnameLabe.text = employee.getSurname()
        self.idNumberLabel.text = employee.getID()
        self.navigationItem.title = employee.getName() + " " + employee.getSurname()
        
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
            // resizeImage(image!, newWidth: 200)
            let postRequest = NetworkRequestsTests(functions.resizeImage(image: image, newWidth: 1000))
            postRequest.postData(completion: { (message) in
                
                DispatchQueue.main.async {
                    print("OK It work!")
                }
            })
            
            imageEmployeeView.image = functions.resizeImage(image: image, newWidth: imageEmployeeView.bounds.size.width)
            
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
