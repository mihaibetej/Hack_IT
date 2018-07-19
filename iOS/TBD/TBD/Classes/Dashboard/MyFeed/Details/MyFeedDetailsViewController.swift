//
//  MyFeedDetailsViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation
import UIKit

class MyFeedDetailsViewController: UIViewController {
    public var feedItem: FeedItemModel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.text = feedItem.text
    }
}
