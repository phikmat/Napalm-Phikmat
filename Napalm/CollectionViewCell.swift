//
//  CollectionViewCell.swift
//  Napalm
//
//  Created by Mattia Picariello on 10/04/2017.
//  Copyright © 2017 NewppyTeam. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var surnameLabel: UILabel!
    @IBOutlet var imageEmployee: UIImageView!
    @IBOutlet var roleEmployee: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        functions.setBorderRadiusImageView(imageView: imageEmployee)
        // Initialization code
    }
}
