//
//  ContactCell.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        distanceLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ contact: Contact) {
        contactNameLabel.text = contact.fullname
        distanceLabel.text = nil
    }
    
    func configure(_ contact: Contact, distance: Int) {
        contactNameLabel.text = contact.fullname
        
        let distanceText: String
        
        switch distance {
        case 0...1000:
            distanceText = "within 1 km"
        case 1000...5000:
            distanceText = "within 5 km"
        case 5000...10000:
            distanceText = "within 10 km"
        default:
            distanceText = "more than 10 km away"
        }
        
        distanceLabel.text = distanceText
    }

}
