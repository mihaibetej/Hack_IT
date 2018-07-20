//
//  IncomingMessageCell.swift
//  TBD
//
//  Created by Mihai Betej on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class IncomingMessageCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var incomingMessageContainer: UIView!
    @IBOutlet weak var incomingMessageContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var incomingMessageContainerTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var incomingContactImageView: UIImageView!
    @IBOutlet weak var incomingContactImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var incomingContactImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var incomingContactImageViewHeightConstraint: NSLayoutConstraint!
    
    
    let defaultContainerHeight: CGFloat = 38
    let defaultContainerTrailing: CGFloat = 48
    let defaultImageLeadingConstant: CGFloat = 10
    let defaultImageWidthConstant: CGFloat = 28

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        incomingMessageContainer.layer.cornerRadius = 8
        
        // Message container
        incomingMessageContainer.backgroundColor = .white
        
        // Shadow mask
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 1

    }
    
    func configure(_ message: Message, previousMessage: Message? = nil, isGroupMessage: Bool = false) {
        var maxW = bounds.width - defaultContainerTrailing - 10
        // Adjust for avatar
        if message.type == .incoming && isGroupMessage {
            maxW = maxW - 10 - incomingContactImageView.bounds.width
            incomingContactImageViewLeadingConstraint.constant = defaultImageLeadingConstant
            incomingContactImageViewWidthConstraint.constant = defaultImageWidthConstant
        } else {
            incomingContactImageViewLeadingConstraint.constant = 0
            incomingContactImageViewWidthConstraint.constant = 0
        }
        
        let maxH = CGFloat.greatestFiniteMagnitude
        let requiredMessageLabelSize = (message.content as NSString).boundingRect(with: CGSize(width: maxW - 16, height: maxH), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : messageLabel.font], context: nil)
        
        incomingMessageContainerHeightConstraint.constant = ceil(requiredMessageLabelSize.height) + 12
        incomingMessageContainerTrailingConstraint.constant = bounds.width - ceil(requiredMessageLabelSize.width) - 16 - 10
        layoutIfNeeded()
        
        messageLabel.text = message.content
        
        if previousMessage?.sender != message.sender && isGroupMessage {
            incomingContactImageView.image = UIImage(named: "user_male")
        } else {
            incomingContactImageView.image = nil
        }

    }

}
