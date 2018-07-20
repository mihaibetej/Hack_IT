//
//  MessagesViewController.swift
//  TBD
//
//  Created by Mihai Betej on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit
import NextGrowingTextView

protocol MessagesDelegate {
    func update(contact: Contact)
}

class MessagesViewController: UIViewController {
    
    var contact: Contact?
    var me: Contact = Contact(fullname: "Me", messages: nil)
    var group: Group?
    var messages = [Message]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputSeparatorView: UIView!
    @IBOutlet weak var inputSeparatorViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var growingTextView: NextGrowingTextView!
    @IBOutlet weak var growingTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    var showKeyboardInChatScreen: Bool = true
    var delegate: MessagesDelegate?
    var alfyMessageIndex = 0
    
    var alfieMessagesContents = [
        "Hi there, Rafael! My name is Alfred and I am your personal assistant. I can help you with advice, information or I can find a new friend for you. Please select one of the options at the bottom of the screen",
        "Can do! I can give you information about different aspects of leukaemia such as treatment, medication, side effects or ways to recover after treatment.",
        "I can access a huge database for you, all you have to do is tell me the name of the medicine you're interested about.",
        "I found 2 articles and one glossary entry for Cytarabine",
        "I hope that was helpful, Mark. Can I help you with anything else?",
        "Right on! I will now use my super powers to find a chat buddy for you. This might take a while but don't worry. Once I find someone I will send you a private message. see you in the Messages section!",
        "Erin meet Mark. Mark, meet Erin.",
        "You both said you need someone to talk to. It's always a good ideea to meet new people from new places that are going through the same thing as you and learn new things from them",
        "Looks like you both like traveling, why not start with that?",
        "As for me, battery recharging time!"
    ]
    var alfieMessages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if contact == nil && group == nil {
            installAlfieMock()
            group = Group(name: "Alfred", contacts: [Contact(fullname: "Alfred", messages: [alfieMessages.first!]), MessagesOverviewViewController.erin])
            alfyMessageIndex += 1

            let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissController))
            navigationItem.rightBarButtonItem = button
        }
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
        growingTextView.placeholderAttributedText = NSAttributedString(string: "Type your message...",
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
        
        // Incoming messages
        if let contact = contact, let contactMessages = contact.messages {
            messages.append(contentsOf: contactMessages)
        } else if let group = group {
            for contact in group.contacts {
                if let contactMessages = contact.messages {
                    messages.append(contentsOf: contactMessages)
                }
            }
        }
        
        // Dsimiss keyboard gesture
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(MessagesViewController.dismissKeyboard(_:)))
        tapGR.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGR)
        
        // Table view
        tableView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showKeyboardInChatScreen {
            growingTextView.textView.becomeFirstResponder()
        }
    }
    
    @objc func dismissController(sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @objc func dismissKeyboard(_ sender: Any) {
        growingTextView.textView.resignFirstResponder()
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
        messages.append(Message(content: myMessageContent, type: .outgoing, sender: "Me"))
        if me.messages == nil {
            me.messages = [messages.last!]
        } else {
            me.messages!.append(messages.last!)
        }
        
        if contact != nil {
            if contact?.messages == nil {
                contact?.messages = [Message]()
            }
            contact!.messages!.append(messages.last!)
            delegate?.update(contact: contact!)
        } else if alfieMessages.count > 0 && alfyMessageIndex < alfieMessagesContents.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.messages.append(self.alfieMessages[self.alfyMessageIndex])
                self.alfyMessageIndex += 1
                self.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                    if numberOfRows > 0 {
                        let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }

                    if self.alfyMessageIndex == 6 { // Meet Erin
                        self.messages.append(Message(content: "Erin has joined the chat", type: .incoming, sender: "Erin"))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            self.tableView.reloadData()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                                if numberOfRows > 0 {
                                    let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                                }
                                self.alfieMonologue1()
                            }
                        }
                    }
                }
            }
        }
        
        growingTextView.textView.text = ""
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let numberOfRows = self.tableView.numberOfRows(inSection: 0)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
}

// MARK: - Cell actions delegate

extension MessagesViewController: CellActionsDelegate {
    
    func navigateToArticles() {
        
    }
    
    func navigateToGlossary() {
        let storyboard = UIStoryboard(name: "Information", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String.init(describing: WebViewController.self)) as! WebViewController
        // Hack to load the view
        print(controller.view.frame)
        // Then carry on ... my wayward child...
        controller.dismissButton.isHidden = true
        controller.textHTML = "Cytarabine is used to treat different forms of leukemia, including acute and chronic myelogenous leukemia (AML and CML), acute lymphocytic leukemia (ALL), and acute promyelocytic leukemia (APL). It is also used to treat Hodgkin's lymphoma, as well as meningeal leukemia and other types of lymphoma (cancers found in the lining of the brain and spinal cord)."
        controller.title = "Cytarabine"
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func chatWithErin() {
        dismiss(animated: true) {
            CustomTabBarController.sharedInstance.selectedIndex = 4
            guard let navController = CustomTabBarController.sharedInstance.selectedViewController as? UINavigationController else { return }
            guard let messagesOverviewVC = navController.topViewController as? MessagesOverviewViewController else {return}            
            messagesOverviewVC.addErinAndNavigate = true
            messagesOverviewVC.loadViewIfNeeded()            
        }
        
    }
    
}

// MARK: - Table view

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        let message = messages[indexPath.row]
        if message.type == .incoming {
            cell = tableView.dequeueReusableCell(withIdentifier: "IncomingMessageCell", for: indexPath) as! IncomingMessageCell
            if group != nil {
                let previousMessage: Message? = indexPath.row == 0 ? nil : messages[indexPath.row - 1]
                (cell as! IncomingMessageCell).configure(message,
                                                         previousMessage: previousMessage,
                                                         isGroupMessage: true,
                                                         showActions: indexPath.row == 6,
                                                         showAction: indexPath.row == 15,
                                                         delegate: self)
            } else {
                (cell as! IncomingMessageCell).configure(message, delegate: self)
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingMessageCell", for: indexPath) as! OutgoingMessageCell
            (cell as! OutgoingMessageCell).configure(message)
        }
        
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
                }) { (finished) in
                    let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                    if numberOfRows > 0 {
                        let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
            }
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                inputContainerViewBottomConstraint.constant = -keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.layoutIfNeeded()
                }) { (finished) in
                    let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                    if numberOfRows > 0 {
                        let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
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
    
    func installAlfieMock() {
        alfieMessages.removeAll()
        for i in 0..<alfieMessagesContents.count {
            let message = Message(content: alfieMessagesContents[i], type: .incoming, sender: "Alfred")
            alfieMessages.append(message)
        }
    }
    
    func alfieMonologue1() {
        messages.append(self.alfieMessages[self.alfyMessageIndex])
        alfyMessageIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
                self.alfieMonologue2()
            }
        }

    }
    
    func alfieMonologue2() {
        messages.append(self.alfieMessages[self.alfyMessageIndex])
        alfyMessageIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
                self.alfieMonologue3()
            }
        }
        
    }
    
    func alfieMonologue3() {
        messages.append(self.alfieMessages[self.alfyMessageIndex])
        alfyMessageIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
                self.alfieMonologue4()
            }
        }
        
    }
    
    func alfieMonologue4() {
        messages.append(self.alfieMessages[self.alfyMessageIndex])
        alfyMessageIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
        
    }
    
}
