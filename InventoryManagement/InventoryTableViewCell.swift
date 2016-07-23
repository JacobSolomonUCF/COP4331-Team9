//
//  InventoryTableViewCell.swift
//  InventoryManagement
//
//  Created by Robert Brown on 7/20/16.
//  Copyright © 2016 CNT4331-Team9. All rights reserved.
//

import UIKit

class InventoryTableViewCell: UITableViewCell {
    
    // MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
