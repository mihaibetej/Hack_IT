//
//  PrivateMessageCell.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class PrivateMessageCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ contact: Contact) {
        nameLabel.text = contact.fullname
    }

}
