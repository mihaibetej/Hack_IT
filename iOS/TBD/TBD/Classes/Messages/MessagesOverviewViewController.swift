//
//  MessagesOverview.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

enum ChatMode: Int {
    case `private`
    case group
}

class MessagesOverviewViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var contacts = [Contact]()
    private var groups = [Group]()
    
    var chatMode: ChatMode = .private
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contacts = [Contact(fullname: "Kthulu"), Contact(fullname: "John Doe"), Contact(fullname: "Mr. Smith"), Contact(fullname: "Hercule Poirot")]
        groups = [Group(name: "Cooking"), Group(name: "Chess club")]
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectionUpdate(_ sender: Any) {
        chatMode = ChatMode(rawValue: segmentedControl.selectedSegmentIndex) ?? .private
        tableView.reloadData()
    }
    
}

extension MessagesOverviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chatMode == .private {
            return contacts.count
        }
        
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if chatMode == .private {
            cell = tableView.dequeueReusableCell(withIdentifier: "PrivateMessageCell", for: indexPath) as! PrivateMessageCell
            (cell as! PrivateMessageCell).configure(contacts[indexPath.row])
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "GroupMessageCell", for: indexPath) as! GroupMessageCell
            (cell as! GroupMessageCell).configure(groups[indexPath.row])
        }
        
        return cell
    }
    
    // MARK: Delegate
    
}
