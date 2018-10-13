//
//  ChatHistoryVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-08.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol ChatHistoryVCDelegate: class {
    func chatHistoryVC(userId: String)
}

class ChatHistoryVC: NavigationBaseVC {
    
    // Data
    var chatInfo: ChatInfo?
    
    weak var delegate: ChatHistoryVCDelegate?
    
    // UI
    var tableView: UITableView!
    var inputBox: ChatInputBox!
    var inputBoxBottom: UIView! // fix for iphone x display
    var dataSource = [MessageInfo]()
    
    // DB
    var ref = Firestore.firestore().collection("messages")
    var listener: ListenerRegistration!
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString(chatInfo?.title ?? "WeeChat History", comment: "")
        
        renderContent()
        
        fetchMessages()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.listener.remove()
    }
    
    func renderContent() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(ChatBubbleRowCell.self, forCellReuseIdentifier: "Bubble")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        inputBox = ChatInputBox()
        inputBox.translatesAutoresizingMaskIntoConstraints = false
        inputBox.textInput.delegate = self
        self.view.addSubview(inputBox)
        
        inputBoxBottom = UIView()
        inputBoxBottom.backgroundColor = UIColor.secondaryGrey
        self.view.addSubview(inputBoxBottom)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[table]|",
            options: [],
            metrics: nil,
            views: ["table": tableView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[input]|",
            options: [],
            metrics: nil,
            views: ["input": inputBox]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[table]|",
            options: [],
            metrics: nil,
            views: ["table": tableView]))
        
        // pin input box at the bottom
        bottomConstraint = NSLayoutConstraint(item: inputBox, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(bottomConstraint!)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            // Animate with keyboard
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                // move to the last message
//                let count = self.dataSource.count == 0 ? 1 : self.dataSource.count
//                let indexPath = IndexPath(item: count - 1, section: 0)
//                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            })
        }
    }
    
    func fetchMessages() {
        if let chatId = chatInfo?.chatId {
            ref = Firestore.firestore().collection("messages").document(chatId).collection("messages")
            self.listener = ref.addSnapshotListener { (documents, error) in
                guard let snapshot = documents else {
                    return
                }
                self.dataSource = snapshot.documents.map { (document) -> MessageInfo in
                    if let message = MessageInfo(dictionary: document.data()) {
                        return message
                    } else {
                        return MessageInfo(content: "Test", senderId: "Test", senderName: "Test")
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    func addMessage() {
        let data = MessageInfo(
            content: inputBox.getMessage(),
            senderId: UDSM.user?.id ?? "",
            senderName: UDSM.user?.name ?? "")
        
        ref.addDocument(data: data.dictionary)
        
        inputBox.clearMessage()
        tableView.reloadData()
    }
    
}

extension ChatHistoryVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addMessage()
        return true
    }
}

extension ChatHistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        inputBox.endEditing(true)
    }
}

extension ChatHistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Bubble", for: indexPath) as! ChatBubbleRowCell
        cell.message = dataSource[indexPath.row].content
        cell.isIncoming = dataSource[indexPath.row].senderId != UDSM.user?.id ?? ""
        cell.showMessage()
        return cell
    }
    
    
}
