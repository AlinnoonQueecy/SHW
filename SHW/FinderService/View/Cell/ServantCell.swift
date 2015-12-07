//
//  ServantCell.swift
//  
//
//  Created by Zhang on 15/11/29.
//
//

import UIKit

class ServantCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var servantname: UILabel!
    
    @IBOutlet weak var facilitator: UILabel!
    
    @IBOutlet weak var salaryTitle: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var salaryUnit: UILabel!
    @IBOutlet weak var scoreTitle: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var serviceCountTitle: UILabel!

    @IBOutlet weak var serviceCount: UILabel!
    
    @IBOutlet weak var StatusButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}






