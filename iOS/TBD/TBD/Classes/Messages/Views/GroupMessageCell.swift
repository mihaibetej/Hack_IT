//
//  GroupMessageCell.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class GroupMessageCell: UITableViewCell {

    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastContactLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        groupImageView.layer.masksToBounds = true
        groupImageView.layer.cornerRadius = groupImageView.frame.height / 2
    }

    func configure(_ group: Group) {
        groupImageView.image = UIImage(named: "group")
        nameLabel.text = group.name
        if let fullname = group.contacts.first?.fullname {
            lastContactLabel.text = "\(fullname):"
        }
        lastMessageLabel.text = group.contacts.first?.messages?.first?.content
    }
}
