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
        // Prepopulate some private messages
        let poirot = Contact(fullname: "Hercule Poirot", messages: [Message(content: "Hey, have you finally solved that train mistery that was bugging you so much?")])
        let lovelace = Contact(fullname: "Ada Lovelace", messages: [Message(content: "Working on this computer is soooo exciting! It's surely going to lead to a revolution in our lives!")])
        let bond = Contact(fullname: "James Bond", messages: [Message(content: "I've been expecting you, Mr. Bond")])
        contacts = [poirot, lovelace, bond]
        
        // Prepopulate some groups:
        let kasparov = Contact(fullname: "Garry Kasparov", messages: [Message(content: "Deep Blue is ruining the game for everybody :(")])
        let chessClub = Group(name: "Chess Club", contacts: [kasparov])
        let sherlock = Contact(fullname: "Sherlock Holmes", messages: [Message(content: "Hey, have you finally solved that train mistery that was bugging you so much?")])
        let detectiveClub = Group(name: "Detective Club", contacts: [sherlock, poirot])
        groups = [chessClub, detectiveClub]
        
        // Refresh
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let senderCell = sender as? UITableViewCell, let index = tableView.indexPath(for: senderCell)?.row else {
            return
        }
        
        let messagesController = segue.destination as! MessagesViewController
        
        if chatMode == .private {
            messagesController.contact = contacts[index]
        } else {
            messagesController.group = groups[index]
        }
    }
    
    // MARK: Actions
    
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
}
