//
//  MessagesVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-31.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class ChatOverviewVC: NavigationBaseVC {
    
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
        
        renderContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
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
        if let title = dataSource[indexPath.row].senderName {
            cell.titleLabel.text = title
        }
        if let subtitle = dataSource[indexPath.row].content {
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
