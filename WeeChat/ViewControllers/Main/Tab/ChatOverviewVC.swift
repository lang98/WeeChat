//
//  MessagesVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-31.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class ChatOverviewVC: NavigationBaseVC {
    
    var tableView: UITableView!
    
    var dataSource = [ChatInfo]()
    var ref = Firestore.firestore().collection("chats")
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderContent()
        fetchAllChats()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.listener.remove()
    }
    
    func fetchAllChats() {
        self.listener = ref.addSnapshotListener { (documents, error) in
            guard let snapshot = documents else {
                return
            }
            self.dataSource = snapshot.documents.map { (document) -> ChatInfo in
                print(document.data())
                if let chat = ChatInfo(dictionary: document.data(), id: document.documentID) {
                    return chat
                } else {
                    fatalError("Chat overview cant get data from firebase")
                }
            }
            self.tableView.reloadData()
        }
        
        
    }
    
    private func renderContent() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = Constants.Size.heightChatCellView
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[table]|",
            options: [],
            metrics: nil,
            views: ["table": tableView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[table]|",
            options: [],
            metrics: nil,
            views: ["table": tableView]))
    }
}

extension ChatOverviewVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatTableViewCell
        if let title = dataSource[indexPath.row].chatId {
            cell.titleLabel.text = title
        }
        if let subtitle = dataSource[indexPath.row].chatId {
            cell.subTitleLabel.text = subtitle
        }
        return cell
    }
}

extension ChatOverviewVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let vc = ChatHistoryVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChatOverviewVC: ChatHistoryVCDelegate {
    func chatHistoryVC(userId: String) {
        
    }
}
