//
//  CommentCell.swift
//  SHW
//
//  Created by Zhang on 15/8/6.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class CommentTCell: UITableViewCell {

    @IBOutlet weak var customer: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
