//
//  TableViewCell.swift
//  未完成订单
//
//  Created by appl on 15/6/9.
//  Copyright (c) 2015年 appl. All rights reserved.
//

import UIKit

class FinishTVCell: UITableViewCell {
    
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var facilitator: UILabel!
    @IBOutlet weak var servantName: UILabel!
    @IBOutlet weak var servicePay: UILabel!
       
    @IBOutlet weak var pic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
