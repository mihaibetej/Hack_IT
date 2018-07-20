//
//  OutgoingMessageCell.swift
//  TBD
//
//  Created by Mihai Betej on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class OutgoingMessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var outgoingMessageContainer: UIView!
    @IBOutlet weak var outgoingMessageContainerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var outgoingMessageContainerLeadingConstraint: NSLayoutConstraint!
    
    let defaultContainerHeight: CGFloat = 36
    let defaultContainerLeading: CGFloat = 48
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        outgoingMessageContainer.layer.cornerRadius = 8
    }
    
    func configure(_ message: Message) {
        let maxW = bounds.width - defaultContainerLeading - 10
        let maxH = CGFloat.greatestFiniteMagnitude
        let requiredMessageLabelSize = (message.content as NSString).boundingRect(with: CGSize(width: maxW - 16, height: maxH), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : messageLabel.font], context: nil)
        
        outgoingMessageContainerHeightConstant.constant = ceil(requiredMessageLabelSize.height) + 12
        outgoingMessageContainerLeadingConstraint.constant = bounds.width - ceil(requiredMessageLabelSize.width) - 16 - 10
        layoutIfNeeded()
        
        messageLabel.text = message.content
    }

}
