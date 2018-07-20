//
//  FAQTableViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class FAQTableViewControllerCell: UITableViewCell {
    
    @IBOutlet weak var fullWidthImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
    }
}

class FAQTableViewController: UITableViewController {
    
    let datasource = [
        #imageLiteral(resourceName: "FAQ1"),
        #imageLiteral(resourceName: "FAQ2"),
        #imageLiteral(resourceName: "FAQ3"),
        #imageLiteral(resourceName: "FAQ4")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FAQTableViewControllerCell

        cell.fullWidthImageView.image = datasource[indexPath.row]

        return cell
    }
}
