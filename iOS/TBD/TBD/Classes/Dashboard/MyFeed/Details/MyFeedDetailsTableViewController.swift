//
//  MyFeedDetailsViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation
import UIKit

class MyFeedDetailsTableViewController: UITableViewController {
    public var feedItem: FeedItemModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItem.comments.count + 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            tableCell = cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailsCell", for: indexPath) as? ItemDetailsTableViewCell else {
                preconditionFailure()
            }
            cell.setupWith(itemDetails: feedItem)
            tableCell = cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCountCell", for: indexPath)
            tableCell = cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as? CommentsTableViewCell else {
                preconditionFailure()
            }
            cell.setupWith(comment: feedItem.comments[indexPath.row - 3])
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
}
