//
//  WondersTableViewCell.swift
//  tableView
//
//  Created by MCDA on 2019-07-20.
//  Copyright © 2019 MCDA. All rights reserved.
//

import UIKit

class WondersTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var icon_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
