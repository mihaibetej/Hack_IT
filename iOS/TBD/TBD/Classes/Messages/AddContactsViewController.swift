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

class AddContactsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    private var nearbyContacts: [Contact] = [Contact]()
    private var allContacts: [Contact] = [Contact]()
    private var contactType: ContactType = .nearby
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Nearby
        nearbyContacts.append(Contact(fullname: "Paul Allen", messages: nil))
        nearbyContacts.append(Contact(fullname: "Michael C. Hall", messages: nil))
        nearbyContacts.append(Contact(fullname: "Mr. T", messages: nil))
        // All
        allContacts.append(Contact(fullname: "Stephen Curry", messages: nil))
        allContacts.append(Contact(fullname: "Kevin Durant", messages: nil))
        allContacts.append(Contact(fullname: "Lebron James", messages: nil))
        allContacts.append(Contact(fullname: "Reggie Miller", messages: nil))
        
    }
    
    // MARK: Actions
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        // ... logic here
        contactType = ContactType(rawValue: segmentedControl.selectedSegmentIndex) ?? .nearby
        tableView.reloadData()
    }
    
}

extension AddContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contactType == .nearby {
            return nearbyContacts.count
        }
        
        return allContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        if contactType == .nearby {
            cell.configure(nearbyContacts[indexPath.row])
        } else {
            cell.configure(allContacts[indexPath.row])
        }
        
        return cell
    }
    
    // MARK: Delegate
    
}
