//
//  MyFeedViewController.swift
//  TBD
//
//  Created by Florin Voicu on 7/19/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

protocol FeedItemAddable: class {
    func addNewFeedItem()
}

protocol ItemExpandable: class {
    func expandItem()
}

class MyFeedViewController: UITableViewController {

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
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedHeaderCell", for: indexPath) as? MyFeedHeaderTableViewCell else {
                preconditionFailure()
            }
            cell.delegate = self
            tableCell = cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemCell", for: indexPath) as? MyFeedItemTableViewCell else {
                preconditionFailure()
            }
            cell.setupCellWith(name: "What's my name",
                               text: "jfbfajg sfn fn jb agjbjb bkg fsj gbj n nakjg s gb akjfkjnfakj ngkfgj gk ak anfgkjan kn kjnk k ak kj nakj k skj akj kkj k ngj njr nkjrntkjnkj njnjn kjnbkjn kjn j j kj nk kjkjbkj b kjb b kjbkj b kjb kjb kb kjb kb kjb kjbk jbk jb kj kjb kjb kj jb kjb kj bkj kj nk jnk jn kjb j kb kj bkj bkj b kb kjb kjb kj bkj bkj  jb kb kjb kj bk bkj b kbb k b kb kjb kjb b k ",
                               mediaThumb: nil)
            tableCell = cell
        }
        
        return tableCell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyFeedViewController: ItemExpandable, FeedItemAddable {
    func expandItem() {
        
    }
    
    func addNewFeedItem() {
        
    }
}
