//
//  ListNoteTableViewCell.swift
//  Notes
//
//  Created by Hoang Son on 11/6/18.
//  Copyright © 2018 Hoang ap. All rights reserved.
//

import UIKit

class ListNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var lbNameNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
