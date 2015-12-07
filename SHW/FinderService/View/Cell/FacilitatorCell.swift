//
//  FacilitatorCell.swift
//  
//
//  Created by Zhang on 15/11/30.
//
//

import UIKit

class FacilitatorCell: UITableViewCell {

    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var contentlabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
