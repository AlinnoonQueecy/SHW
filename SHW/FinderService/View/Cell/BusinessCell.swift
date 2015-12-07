//
//  BusinessCell.swift
//  SHW
//
//  Created by Zhang on 15/6/4.
//  Copyright (c) 2015年 star. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var officePhone: UILabel!
  
    
    @IBOutlet weak var dizhi: UILabel!
    
    @IBOutlet weak var dianhua: UILabel!
    
  
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
