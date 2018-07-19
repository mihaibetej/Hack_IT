//
//  MyFeedItemTableViewCell.swift
//  TBD
//
//  Created by Florin Voicu on 7/19/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class MyFeedItemTableViewCell: UITableViewCell {
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var mediaThumbImageView: UIImageView!
    @IBOutlet weak var mediaThumbHeight: NSLayoutConstraint!
    @IBOutlet weak var mediaThumbSpaceToTextContent: NSLayoutConstraint!
    let mediaThumbHeightConstant: CGFloat = 150
    
    weak var delegate: ItemExpandable?
    
    func setupCellWith(name: String, text: String, mediaThumb: UIImage? = nil) {
        posterName.text = name
        textContentLabel.text = text
        if let mediaThumb = mediaThumb {
            mediaThumbImageView.image = mediaThumb
            mediaThumbHeight.constant = mediaThumbHeightConstant
        } else {
            mediaThumbSpaceToTextContent.constant = 0
        }
    }
    
    @IBAction func expandItem(_ sender: Any) {
        delegate?.expandItem()
    }
}
