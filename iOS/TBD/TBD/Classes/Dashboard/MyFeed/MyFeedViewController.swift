//
//  MyFeedViewController.swift
//  TBD
//
//  Created by Florin Voicu on 7/19/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class MyFeedViewController: UITableViewController {
    
    var feedItemsDatasource = FeedDatasource.instance
    var selectedCellIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItemsDatasource.items.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedHeaderCell", for: indexPath) as? MyFeedHeaderTableViewCell else {
                preconditionFailure()
            }
            tableCell = cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemCell", for: indexPath) as? MyFeedItemTableViewCell else {
                preconditionFailure()
            }
            let feedItem = feedItemsDatasource.items[indexPath.row-1]
            cell.setupCellWith(feedItem: feedItem)
            cell.index = indexPath.row
            cell.delegate = self
            tableCell = cell
        }
        
        tableCell.contentView.layer.masksToBounds = false
        tableCell.contentView.layer.shadowOpacity = 0.1
        tableCell.contentView.layer.shadowColor = UIColor.black.cgColor
        tableCell.contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        tableCell.contentView.layer.shadowRadius = 10
        
        return tableCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let navController = segue.destination as? UINavigationController {
            if let postController = navController.topViewController as? PostContentViewController {
                postController.delegate = self
            }
        }
        else if let detailsViewController = segue.destination as? MyFeedDetailsTableViewController {
            detailsViewController.feedItem = feedItemsDatasource.items[selectedCellIndex! - 1]
            selectedCellIndex = nil
        }
    }
}

extension MyFeedViewController: PostContentViewControllerDelegate {
    func didCreatePost(item: FeedItemModel) {
        feedItemsDatasource.addNew(item: item)
        tableView.reloadData()
    }
}

extension MyFeedViewController: ItemExpandable {
    func expandItem(at index: Int) {
        selectedCellIndex = index
        performSegue(withIdentifier: "showFeedItemDetails", sender: self)
    }
}
