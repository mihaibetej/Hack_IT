//
//  ArticlesViewController.swift
//  TBD
//
//  Created by Stefan Olaru on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let images = ["1", "2", "3", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Scientific Articles"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WhiteCell", for: indexPath) as! WhiteTableViewCell
            tableCell = cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {
                preconditionFailure()
            }
            cell.articleImage.image = UIImage.init(named: images[0] )
            tableCell = cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WhiteCell", for: indexPath) as! WhiteTableViewCell
            tableCell = cell
        } else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {
                preconditionFailure()
            }
            cell.articleImage.image = UIImage.init(named: images[1] )
            tableCell = cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WhiteCell", for: indexPath) as! WhiteTableViewCell
            tableCell = cell
        } else if indexPath.row == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {
                preconditionFailure()
            }
            cell.articleImage.image = UIImage.init(named: images[2] )
            tableCell = cell
        }  else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WhiteCell", for: indexPath) as! WhiteTableViewCell
            tableCell = cell
        } else  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {
                preconditionFailure()
            }
            cell.articleImage.image = UIImage.init(named: images[3] )
            tableCell = cell
        }
        
        tableCell.contentView.layer.masksToBounds = false
        tableCell.contentView.layer.shadowOpacity = 0.1
        tableCell.contentView.layer.shadowColor = UIColor.black.cgColor
        tableCell.contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        tableCell.contentView.layer.shadowRadius = 10
        tableCell.contentView.layer.cornerRadius = 5
        tableCell.contentView.clipsToBounds = true
        
        return tableCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            performSegue(withIdentifier: "showArticle", sender: self)
        }
    }
    
    
    
    
    
    
}
