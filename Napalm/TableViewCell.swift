//
//  TableViewCell.swift
//  Napalm
//
//  Created by Mattia Picariello on 03/04/2017.
//  Copyright © 2017 Mattia Picariello. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSurname: UILabel!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var imagePeople: UIImageView!
    @IBOutlet weak var imageRoleIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        functions.setBorderRadiusImageView(imageView: imagePeople)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
