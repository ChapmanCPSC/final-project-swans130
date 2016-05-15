//
//  RecomendedTaskTableViewCell.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/7/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

class RecomendedTaskTableViewCell: UITableViewCell {

    
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
