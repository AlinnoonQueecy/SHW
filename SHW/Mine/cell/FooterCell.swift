//
//  FooterCell.swift
//  
//
//  Created by Zhang on 15/12/5.
//
//

import UIKit

class FooterCell: UITableViewCell {

 
    
    @IBOutlet weak var Picture: UIImageView!
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
