//
//  CustomFunctions.swift
//  Napalm
//
//  Created by Mattia Picariello on 07/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import UIKit

let functions = CustomFunctions()

class CustomFunctions {
    
    
    func setBorderRadiusImageView(imageView: UIImageView!){
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.layer.frame.height/2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(red: 255/255, green: 68/255, blue: 49/255, alpha: 1).cgColor
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newWidth))
        var x: CGFloat = 0
        var y: CGFloat = 0
        if newWidth > newHeight {
            x = -(newWidth - newHeight)/2.0
        } else {
            y = -(newHeight - newWidth)/2.0
        }
        image.draw(in: CGRect(x:x, y:y, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
