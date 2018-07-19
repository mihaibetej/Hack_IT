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
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var incomingMessageContainer: UIView!
    @IBOutlet weak var incomingMessageContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var incomingMessageContainerLeadingConstraint: NSLayoutConstraint!

    
    let defaultContainerHeight: CGFloat = 36
    let defaultContainerTrailing: CGFloat = 48

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        messageContainer.layer.cornerRadius = 8
    }
    
    func configure(_ message: Message) {
//        let maxW = bounds.width - defaultContainerTrailing - 10
//        let maxH = CGFloat.greatestFiniteMagnitude
//        let requiredMessageLabelSize = (message.content as NSString).boundingRect(with: CGSize(width: maxW - 16, height: maxH), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : messageLabel.font], context: nil)
//        
//        incomingMessageContainerHeightConstraint.constant = requiredMessageLabelSize.height + 12
//        incomingMessageContainerLeadingConstraint.constant = bounds.width - requiredMessageLabelSize.width - 16 - 10
//        layoutIfNeeded()
        
        messageLabel.text = message.content

    }

}
