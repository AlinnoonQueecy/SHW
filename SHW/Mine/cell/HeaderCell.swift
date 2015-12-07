//
//  HeaderCell.swift
//  
//
//  Created by Zhang on 15/12/5.
//
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var CustomerName: UILabel!
    @IBOutlet weak var Picture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
