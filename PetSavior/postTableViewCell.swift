//
//  postTableViewCell.swift
//  PetSavior
//
//  Created by kerem on 26/01/2017.
//  Copyright © 2017 ACI. All rights reserved.
//

import UIKit

class postTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
