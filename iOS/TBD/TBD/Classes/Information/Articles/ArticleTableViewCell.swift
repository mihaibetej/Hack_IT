//
//  ArticleTableViewCell.swift
//  TBD
//
//  Created by Stefan Olaru on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
