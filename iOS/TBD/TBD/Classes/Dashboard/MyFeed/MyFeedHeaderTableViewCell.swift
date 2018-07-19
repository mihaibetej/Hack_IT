//
//  MyFeedHeaderTableViewCell.swift
//  TBD
//
//  Created by Florin Voicu on 7/19/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class MyFeedHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    weak var delegate: FeedItemAddable?

    @IBAction func addNewFeedItem(_ sender: Any) {
        delegate?.addNewFeedItem()
    }
}
