//
//  TableViewCell.swift
//  人员信息
//
//  Created by appl on 15/6/15.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var servantName: UILabel!
    @IBOutlet weak var servantID: UILabel!
    @IBOutlet weak var facilitatorName: UILabel!
    @IBOutlet weak var facilitatorID: UILabel!
    @IBOutlet weak var servantLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
