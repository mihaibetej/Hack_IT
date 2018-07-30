//
//  MyFeedItemTableViewCell.swift
//  TBD
//
//  Created by Florin Voicu on 7/19/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

extension UILabel {
    typealias AdditionalAttribute = (type: NSAttributedStringKey, value: Any)
    func halfTextColorChange (fullText : String , changeText : String, color: UIColor, additionalAttributes: [AdditionalAttribute] = []) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(.foregroundColor, value: color , range: range)
        for attrbt in additionalAttributes {
            attribute.addAttribute(attrbt.type, value: attrbt.value, range: range)
        }
        
        self.attributedText = attribute
    }
}

protocol ItemExpandable: class {
    func expandItem(at index: Int)
}

class MyFeedItemTableViewCell: UITableViewCell {
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var mediaThumbImageView: UIImageView!
    @IBOutlet weak var mediaThumbHeight: NSLayoutConstraint!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    let mediaThumbHeightConstant: CGFloat = 98
    var isExpandable = false
    
    weak var delegate: ItemExpandable?
    var index: Int?
    
    func setupCellWith(feedItem: FeedItemModel) {
        
        isExpandable = feedItem.username == "cureleukaemia" && feedItem.reactions == 43
        
        userAvatarImageView.image = feedItem.avatarImage
        
        let hoursString = feedItem.hoursAgo == 1 ? "hour" : "hours"
        let format = "By \(feedItem.username) · \(feedItem.hoursAgo) \(hoursString) ago · \(feedItem.reactions) reactions"
        
        posterName.text = format
        posterName.halfTextColorChange(fullText: format,
                                       changeText: feedItem.username,
                                       color: UIColor(red: 38/255.0, green: 74/255.0, blue: 209/255.0, alpha: 1.0),
                                       additionalAttributes: [UILabel.AdditionalAttribute(type: .font, value: UIFont(name: "ProximaNova-Semibold", size: 11))])
        
        textContentLabel.text = feedItem.text
        
        if feedItem.username == "cureleukaemia" {
            textContentLabel.font = UIFont(name: "ProximaNova-Semibold", size: 15)
        } else {
            textContentLabel.font = UIFont(name: "ProximaNova-Regular", size: 11)
        }
        
        guard let attachment = feedItem.attachment else {
            mediaThumbImageView.image = nil
            mediaThumbHeight.constant = 0
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
            mediaThumbImageView.image = mediaThumb
            mediaThumbHeight.constant = mediaThumbHeightConstant
        } else {
            mediaThumbImageView.image = nil
            mediaThumbHeight.constant = 0
        }
        
        
    }
    
    @IBAction func expandItem(_ sender: Any) {
        if isExpandable {
            delegate?.expandItem(at: index!)
        }
    }
}
