//
//  PostContentViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class PostContentViewController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textArea.text = nil
        textArea.becomeFirstResponder()
    }

}
