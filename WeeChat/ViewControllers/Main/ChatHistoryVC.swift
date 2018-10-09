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

protocol ChatHistoryVCDelegate: class {
    func chatHistoryVC(userId: String)
}

class ChatHistoryVC: NavigationBaseVC {
    
    weak var delegate: ChatHistoryVCDelegate?
    
    var tableView: UITableView!
    var inputBox: ChatInputBox!
    var dataSource = [MessageInfo]()
    var ref = Firestore.firestore().collection("chats")
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("WeeChat History", comment: "")
        
        renderContent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        self.view.addSubview(inputBox)
        
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
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                
            })
        }
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
        cell.isIncoming = dataSource[indexPath.row].senderId != "asdfasdf"
        cell.showMessage()
        return cell
    }
    
    
}
