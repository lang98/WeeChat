//
//  ChatHistoryVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-08.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

protocol ChatHistoryVCDelegate: class {
    func chatHistoryVC(userId: String)
}

class ChatHistoryVC: NavigationBaseVC {
    
    weak var delegate: ChatHistoryVCDelegate?
    
    var tableView: UITableView!
    var dataSource = [MessageInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = [MessageInfo("lol", "2017", "asdfasdf", "test person"),
                      MessageInfo("lol2", "2017", "vayne is good", "ryanniubi"),
                      MessageInfo("lol3", "2017", "ryan is good", "CGUE"),
                      MessageInfo("lol4", "2017", "asdfasdf", "test person"),
                      MessageInfo("lol", "2017", "asdfasdf", "test person"),
                      MessageInfo("lol2", "2017", "vayne is good", "ryanniubi"),
                      MessageInfo("lol3", "2017", "ryan is good", "CGUE"),
                      MessageInfo("lol", "2017", "asdfasdf", "test person"),
                      MessageInfo("lol2", "2017", "vayne is good", "ryanniubi"),
                      MessageInfo("lol3", "2017", "ryan is good", "CGUE")]
        
        self.title = NSLocalizedString("WeeChat History", comment: "")
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(ChatBubbleRowCell.self, forCellReuseIdentifier: "Bubble")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor.clear
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

extension ChatHistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
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
