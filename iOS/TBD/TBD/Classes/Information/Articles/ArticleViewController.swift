//
//  ArticleViewController.swift
//  TBD
//
//  Created by Stefan Olaru on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageArticle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageArticle.layer.masksToBounds = false
        imageArticle.layer.shadowOpacity = 0.1
        imageArticle.layer.shadowColor = UIColor.black.cgColor
        imageArticle.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageArticle.layer.shadowRadius = 10
        
        textView.layer.masksToBounds = false
        textView.layer.shadowOpacity = 0.1
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 5)
        textView.layer.shadowRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
