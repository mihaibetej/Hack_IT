//
//  ItemDetailsTableViewCell.swift
//  TBD
//
//  Created by Florin Voicu on 7/20/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class ItemDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userAvatarView: UIImageView!
    @IBOutlet weak var userDetailsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullTextLabel: UILabel!
    @IBOutlet weak var reactionsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWith(itemDetails: FeedItemModel) {
        guard let attachment = itemDetails.attachment else {
            return
        }
        var mediaThumb: UIImage?
        switch attachment {
        case FeedItemModel.MediaType.image(let imageData):
            mediaThumb = imageData
        case FeedItemModel.MediaType.video( _, let imageData):
            mediaThumb = imageData
        }
        if let mediaThumb = mediaThumb {
            itemImageView.image = mediaThumb
        } else {
            itemImageView.image = nil
            itemImageViewHeight.constant = 0
        }
        
        userAvatarView.image = itemDetails.avatarImage
        
        let hoursString = itemDetails.hoursAgo == 1 ? "hour" : "hours"
        let format = "By \(itemDetails.username) · \(itemDetails.hoursAgo) \(hoursString) ago · \(itemDetails.reactions) reactions"
        
        userDetailsLabel.text = format
        userDetailsLabel.halfTextColorChange(fullText: format,
                                          changeText: itemDetails.username,
                                          color: UIColor(red: 38/255.0, green: 74/255.0, blue: 209/255.0, alpha: 1.0),
                                          additionalAttributes: [UILabel.AdditionalAttribute(type: .font, value: UIFont(name: "ProximaNova-Semibold", size: 11))])
        titleLabel.text = itemDetails.text
        fullTextLabel.text = "Sam Bull, who works as a nurse at the Centre for Clinical Haematology at the Queen Elizabeth Hospital in Birmingham is preparing to take on her very first half marathon to raise funds for Cure Leukaemia.\n\nSam is running the Birmingham Black Country Half Marathon on Saturday 7th July to raise funds to help the patients she treats every day. She is also preparing to take part in the Brindleyplace Dragon Boat Race in the Cure Leukaemia team on June 16th as well so she has an action packed summer in store!\n\nShe said: “I wanted to run for Cure Leukaemia as I now work in the Centre for Clinical Haematology at The Queen Elizabeth Hospital and I know how hard the charity worked to make it’s expansion possible in 2017.\n\nThe Centre is now a fantastic facility to work in allowing us to improve the care we can offer patients battling this horrible disease. The charity has also helped provide key equipment to save time and effort for both staff and patients.\n\nI’m also doing it as my mom passed away from myeloma 15 years ago, the same year Cure Leukaemia was founded, so I know personally how hard it is for families going through not just blood cancers but many other types as well. I am hoping to raise £500 for the charity.\n\nI have never run more than 10km so this will be a real challenge for me as I also suffer with chronic back pain and other problems. That may mean I have to walk some of the 13.1miles but no matter what I will complete it.\n\nIt would mean so much if I could reach my target so please sponsor me via JustGiving by clicking HERE. Thank you."
        
        reactionsLabel.text = "\(itemDetails.reactions) Reactions"
        
    }

}
