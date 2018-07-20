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
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lastMessagePreviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }

    func configure(_ contact: Contact) {
        nameLabel.text = contact.fullname
        if contact.fullname == "Erin" {
            userImageView.image = #imageLiteral(resourceName: "avatar_2")
        } else if contact.fullname == "Ada Lovelace" {
            userImageView.image = UIImage(named: "user_female")
        } else {
            userImageView.image = UIImage(named: "user_male")
        }
        lastMessagePreviewLabel.text = contact.messages?.last?.content
    }

}
