//
//  orderTableViewCell.swift
//  order
//
//  Created by appl on 15/6/18.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class orderTableViewCell: UITableViewCell {

    @IBOutlet weak var infor1: UILabel!
    @IBOutlet weak var infor2: UILabel!
    @IBOutlet weak var infor3: UILabel!
    @IBOutlet weak var infor4: UILabel!
    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
