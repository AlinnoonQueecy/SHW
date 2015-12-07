//
//  packageCell.swift
//  
//
//  Created by Zhang on 15/12/1.
//
//

import UIKit

class packageCell: UITableViewCell {

    @IBOutlet weak var packageImage: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
 
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var facilitator: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
