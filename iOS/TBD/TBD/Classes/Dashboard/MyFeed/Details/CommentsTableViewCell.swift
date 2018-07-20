//
//  CommentsTableViewCell.swift
//  TBD
//
//  Created by Florin Voicu on 7/20/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet weak var userAvatarView: UIImageView!
    
    @IBOutlet weak var uesrInfoLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWith(comment: CommentModel) {
        userAvatarView.image = comment.avatarImage
        commentLabel.text = comment.text
        
        let hoursString = comment.hoursAgo == 1 ? "hour" : "hours"
        let format = "By \(comment.username) · \(comment.hoursAgo) \(hoursString) ago"
        
        uesrInfoLabel.text = format
        uesrInfoLabel.halfTextColorChange(fullText: format,
                                       changeText: comment.username,
                                       color: UIColor(red: 38/255.0, green: 74/255.0, blue: 209/255.0, alpha: 1.0),
                                       additionalAttributes: [UILabel.AdditionalAttribute(type: .font, value: UIFont(name: "ProximaNova-Semibold", size: 11))])
    }

}
