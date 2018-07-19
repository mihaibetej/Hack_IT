//
//  MyFeedItemTableViewCell.swift
//  TBD
//
//  Created by Florin Voicu on 7/19/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

protocol ItemExpandable: class {
    func expandItem(at index: Int)
}

class MyFeedItemTableViewCell: UITableViewCell {
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var mediaThumbImageView: UIImageView!
    @IBOutlet weak var mediaThumbHeight: NSLayoutConstraint!
    let mediaThumbHeightConstant: CGFloat = 150
    
    weak var delegate: ItemExpandable?
    var index: Int?
    
    func setupCellWith(feedItem: FeedItemModel) {
        posterName.text = feedItem.username
        textContentLabel.text = feedItem.text
        guard let attachment = feedItem.attachment else {
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
        }
    }
    
    @IBAction func expandItem(_ sender: Any) {
        delegate?.expandItem(at: index!)
    }
}
