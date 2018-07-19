//
//  MessagesViewController.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {
    
    var contact: Contact?
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = contact?.fullname ?? group!.name
    }
    
}
