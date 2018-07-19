//
//  MessagesViewController.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit
import NextGrowingTextView

class MessagesViewController: UIViewController {
    
    var contact: Contact?
    var me: Contact = Contact(fullname: "Me", messages: nil)
    var group: Group?
    var myMessages = [Message]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputSeparatorView: UIView!
    @IBOutlet weak var inputSeparatorViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var growingTextView: NextGrowingTextView!
    @IBOutlet weak var growingTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = contact?.fullname ?? group!.name
        
        // Input separator
        inputSeparatorViewHeightConstraint.constant = 0.5
        
        // Setup send button
        sendButton.isEnabled = false
        
        // Setup growing text view
        growingTextView.textView.delegate = self
        growingTextView.layer.cornerRadius = 14
        growingTextView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        growingTextView.textView.textContainerInset = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        growingTextView.textView.font = UIFont(name: "ProximaNova-Regular", size: 16)
        growingTextView.placeholderAttributedText = NSAttributedString(string: "Placeholder text",
                                                                            attributes: [NSAttributedStringKey.font: self.growingTextView.textView.font!,
                                                                                         NSAttributedStringKey.foregroundColor: UIColor.gray
            ])
        growingTextView.delegates.willChangeHeight = { [weak self] height in
            guard let `self` = self else { return }
            // Do something
            self.adjustHeight(height)
        }
        
        // Kb notifications
        NotificationCenter.default.addObserver(self, selector: #selector(MessagesViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MessagesViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func addMediaAction(_ sender: Any) {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            
        }))
        ac.addAction(UIAlertAction(title: "Photo & Video Library", style: .default, handler: { (action) in
            
        }))
        ac.addAction(UIAlertAction(title: "Location", style: .default, handler: { (action) in
            
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let myMessageContent = growingTextView.textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        myMessages.append(Message(content: myMessageContent))
        if me.messages == nil {
            me.messages = [myMessages.last!]
        } else {
            me.messages!.append(myMessages.last!)
        }
        growingTextView.textView.text = ""
        tableView.reloadData()
    }
    
}


// MARK: - Table view

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingMessageCell", for: indexPath) as! OutgoingMessageCell
        cell.configure(me.messages![indexPath.row])
        
        return cell
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
}


// MARK: - Text view delegate

extension MessagesViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let finalText = (textView.text as NSString).replacingCharacters(in: range, with: text).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        sendButton.isEnabled = finalText.count > 0
        
        return true
    }
    
}

// MARK: - Notification handling

extension MessagesViewController {
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let _ = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                //key point 0,
                inputContainerViewBottomConstraint.constant = 0
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                inputContainerViewBottomConstraint.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}

// MARK: - Private API

private extension MessagesViewController {
    
    func adjustHeight(_ growingTextFieldHeight: CGFloat) {
        growingTextViewHeightConstraint.constant = growingTextFieldHeight
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
}