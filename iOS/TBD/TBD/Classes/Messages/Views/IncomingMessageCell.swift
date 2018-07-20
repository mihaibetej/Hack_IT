//
//  IncomingMessageCell.swift
//  TBD
//
//  Created by Mihai Betej on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

protocol CellActionsDelegate {
    func navigateToArticles()
    func navigateToGlossary()
    func chatWithErin()
}

class IncomingMessageCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var incomingMessageContainer: UIView!
    @IBOutlet weak var incomingMessageContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var incomingMessageContainerTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var incomingContactImageView: UIImageView!
    @IBOutlet weak var incomingContactImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var incomingContactImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var incomingContactImageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var readArticlesButton: UIButton!
    @IBOutlet weak var readGlossaryEntryButton: UIButton!
    @IBOutlet weak var articleButonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var articleButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var glossaryButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leaveRoomButton: UIButton!
    @IBOutlet weak var leaveRoomButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leaveRoomButtonBottomConstraint: NSLayoutConstraint!
    
    let defaultContainerHeight: CGFloat = 38
    let defaultContainerHeightWithButtons: CGFloat = 64
    let defaultContainerTrailing: CGFloat = 48
    let defaultImageLeadingConstant: CGFloat = 10
    let defaultImageWidthConstant: CGFloat = 28

    var delegate: CellActionsDelegate?
    
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
        contentView.layer.shadowRadius = 2

        // Actions
        readArticlesButton.backgroundColor = UIColor(rgb: 0xf63c0b)
        readArticlesButton.layer.masksToBounds = true
        readArticlesButton.layer.cornerRadius = 2
        
        readGlossaryEntryButton.backgroundColor = UIColor(rgb: 0xf63c0b)
        readGlossaryEntryButton.layer.masksToBounds = true
        readGlossaryEntryButton.layer.cornerRadius = 2
        
        leaveRoomButton.backgroundColor = UIColor(rgb: 0xf63c0b)
        leaveRoomButton.layer.masksToBounds = true
        leaveRoomButton.layer.cornerRadius = 2

    }
    
    func configure(_ message: Message, previousMessage: Message? = nil, isGroupMessage: Bool = false, showActions: Bool = false, showAction: Bool = false, delegate: CellActionsDelegate) {
        self.delegate = delegate
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
        let requiredMessageLabelSize = (message.content as NSString).boundingRect(with: CGSize(width: maxW - 32, height: maxH), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : messageLabel.font], context: nil)
        
        var extraHeight: CGFloat = 12
        if showActions {
            readArticlesButton.alpha = 1
            readGlossaryEntryButton.alpha = 1
            leaveRoomButton.alpha = 0
            
            articleButonHeightConstraint.constant = 20
            glossaryButtonHeightConstraint.constant = 20
            articleButtonBottomConstraint.constant = 6
            extraHeight += readArticlesButton.bounds.height + 6
        } else if showAction {
            readArticlesButton.alpha = 0
            readGlossaryEntryButton.alpha = 0
            leaveRoomButton.alpha = 1
            
            leaveRoomButtonHeightConstraint.constant = 20
            leaveRoomButtonBottomConstraint.constant = 6
            extraHeight += leaveRoomButton.bounds.height + 6
        } else {
            readArticlesButton.alpha = 0
            readGlossaryEntryButton.alpha = 0
            readArticlesButton.alpha = 0
            
            articleButonHeightConstraint.constant = 0
            glossaryButtonHeightConstraint.constant = 0
            articleButtonBottomConstraint.constant = 0
            
            leaveRoomButtonHeightConstraint.constant = 0
            leaveRoomButtonBottomConstraint.constant = 0
        }
        incomingMessageContainerHeightConstraint.constant = ceil(requiredMessageLabelSize.height) + extraHeight
        
        var extraWidth: CGFloat = 0
        if isGroupMessage {
            extraWidth = 10 + 28
        }
        incomingMessageContainerTrailingConstraint.constant = bounds.width - ceil(requiredMessageLabelSize.width + 1 + extraWidth) - 16 - 10
        layoutIfNeeded()
        
        messageLabel.text = message.content
        
        if previousMessage?.sender != message.sender && isGroupMessage {
            incomingContactImageView.image = UIImage(named: "user_male")
        } else {
            incomingContactImageView.image = nil
        }

    }

    // MARK: Actions
    
    @IBAction func readArticlesAction(_ sender: Any) {
        delegate?.navigateToArticles()
    }
    
    @IBAction func readGlossaryEntryActions(_ sender: Any) {
        delegate?.navigateToGlossary()
    }
    
    @IBAction func leaveRoomAction(_ sender: Any) {
        delegate?.chatWithErin()
    }
    
}
