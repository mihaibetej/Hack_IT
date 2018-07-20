//
//  AddContactsViewController.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

enum ContactType: Int {
    case nearby
    case all
}

protocol AddContactsViewControllerDelegate: class {
    func addContactsViewControllerDidSelectContact(contact: Contact)
}

class AddContactsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: AddContactsViewControllerDelegate?

    private var contactType: ContactType = .nearby
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView?.isHidden = true
    }
    
    // MARK: Actions
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        // ... logic here
        contactType = ContactType(rawValue: segmentedControl.selectedSegmentIndex) ?? .nearby
        tableView.tableHeaderView?.isHidden = contactType == .nearby
        tableView.reloadData()
    }
}

extension AddContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if contactType == .nearby {
            return 1
        }
        
        return ContactsDataSource.instance.allContacts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contactType == .nearby {
            return ContactsDataSource.instance.nearbyContacts.count
        }
        
        let contacts = ContactsDataSource.instance.allContacts
        return contacts[contacts.keys.sorted()[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        if contactType == .nearby {
            let tuple = ContactsDataSource.instance.nearbyContacts[indexPath.row]
            cell.configure(tuple.contact, distance: tuple.distance)
        } else {
            let contacts = ContactsDataSource.instance.allContacts
            cell.configure(contacts[contacts.keys.sorted()[indexPath.section]]![indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if contactType == .nearby {
            return nil
        }
        let contacts = ContactsDataSource.instance.allContacts
        return contacts.keys.sorted()[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if contactType == .nearby {
            return nil
        }

        let contacts = ContactsDataSource.instance.allContacts
        return contacts.keys.sorted()
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contacts = ContactsDataSource.instance.allContacts
        delegate?.addContactsViewControllerDidSelectContact(contact: contacts[contacts.keys.sorted()[indexPath.section]]![indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
