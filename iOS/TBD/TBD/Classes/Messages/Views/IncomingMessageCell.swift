//
//  IncomingMessageCell.swift
//  TBD
//
//  Created by Mihai Betej on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class IncomingMessageCell: UITableViewCell {

    @IBOutlet weak var messageContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        messageContainer.layer.cornerRadius = 8
    }
    
    func configure(_ contact: Contact) {
        
    }

}
