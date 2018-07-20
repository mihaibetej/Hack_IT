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
    var showKeyboardInChatScreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Prepopulate some private messages
        let poirot = Contact(fullname: "Hercule Poirot", messages: [Message(content: "Finally solved that train mistery that was bugging me so much. Of course i knew all along who did it, but I must admit he was very clever and it was almost impossible to prove it!", type: .incoming, sender: "Hercule Poirot")])
        let lovelace = Contact(fullname: "Ada Lovelace", messages: [Message(content: "Working on this computer is soooo exciting! It's surely going to lead to a revolution in our lives!", type: .incoming, sender: "Ada Lovelace"), Message(content: "You absolutely must come see it :)", type: .incoming, sender: "Ada Lovelace")])
        let bond = Contact(fullname: "James Bond", messages: [Message(content: "I've been expecting you, Mr. Bond!", type: .outgoing, sender: "Me"), Message(content: "Me and my Aston Martin had some minor inconveniences to reach you darling, but fear not, I am here now ;)", type: .incoming, sender: "James Bond")])
        contacts = [poirot, lovelace, bond]
        
        // Prepopulate some groups:
        let kasparov = Contact(fullname: "Garry Kasparov", messages: [Message(content: "Deep Blue is ruining the game for everybody :(", type: .incoming, sender: "Garry Kasparov")])
        let chessClub = Group(name: "Chess Club", contacts: [kasparov])
        let sherlock = Contact(fullname: "Sherlock Holmes", messages: [Message(content: "Even though Watson does not posses my observation skills, he is still useful in my cases", type: .incoming, sender: "Sherlock Holmes")])
        let detectiveClub = Group(name: "Detective Club", contacts: [sherlock, poirot])
        groups = [chessClub, detectiveClub]
        
        // Refresh
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let senderCell = sender as? UITableViewCell, let index = tableView.indexPath(for: senderCell)?.row {
            let messagesController = segue.destination as! MessagesViewController
            
            if chatMode == .private {
                messagesController.contact = contacts[index]
                messagesController.showKeyboardInChatScreen = showKeyboardInChatScreen
                messagesController.delegate = self
                showKeyboardInChatScreen = false
            } else {
                messagesController.group = groups[index]
            }
        }
        
        if let navController = segue.destination as? UINavigationController {
            if let addContactsViewController = navController.topViewController as? AddContactsViewController {
                addContactsViewController.delegate = self
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func selectionUpdate(_ sender: Any) {
        chatMode = ChatMode(rawValue: segmentedControl.selectedSegmentIndex) ?? .private
        tableView.reloadData()
    }
    
}

extension MessagesOverviewViewController: MessagesDelegate {
    
    func update(contact: Contact) {
        var index = -1
        for i in 0..<contacts.count {
            if contacts[i].fullname == contact.fullname {
                index = i
                break
            }
        }
        
        if index > -1 {
            contacts[index].messages = contact.messages
        }
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

extension MessagesOverviewViewController : AddContactsViewControllerDelegate {
    func addContactsViewControllerDidSelectContact(contact: Contact) {
        segmentedControl.selectedSegmentIndex = 0
        chatMode = .private
        contacts.insert(contact, at: 0)
        tableView.reloadData()
        
        showKeyboardInChatScreen = true
        performSegue(withIdentifier: "showPrivateChat", sender: tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
    }
}
