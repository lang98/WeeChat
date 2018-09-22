//
//  MeVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-19.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class MeVC: NavigationBaseVC {
    
    var tableView: UITableView!
    var signoutButton: UIButton!
    
    var dataSource = [
        [MenuItem(image: UIImage(named: "MyPosts"), title: "My Posts"),
         MenuItem(image: UIImage(named: "StickerGallery"), title: "Sticker Gallery")],
        [MenuItem(image: UIImage(named: "Settings"), title: "Settings")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderContent()
    }
    
    func renderContent() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(MenuRowCell.self, forCellReuseIdentifier: "Menu")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        signoutButton = UIButton()
        signoutButton.setTitle(NSLocalizedString("Sign out", comment: ""), for: .normal)
        signoutButton.backgroundColor = UIColor.red
        signoutButton.addTarget(self, action: #selector(self.signoutAction), for: .touchUpInside)
        signoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signoutButton)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[table]|",
            options: [],
            metrics: nil,
            views: ["table": tableView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|-(20)-[signoutButton]-(20)-|",
            options: [],
            metrics: nil,
            views: ["signoutButton": signoutButton]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[table]-(20)-[signoutButton]-(60)-|",
            options: [],
            metrics: nil,
            views: ["table": tableView, "signoutButton": signoutButton]))
    }
    
    @objc func signoutAction() {
        do {
            try Auth.auth().signOut()
        } catch {
            // do nothing
        }
        UDSM.clearUserData()
        AppDelegate.delegate.showLoginScreen()
    }
}

extension MeVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        view.backgroundColor = .secondaryBackground
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath) as! MenuRowCell
        cell.iconView.tintColor = UIColor.blue
        if let image = dataSource[indexPath.section][indexPath.row].image,
            let title = dataSource[indexPath.section][indexPath.row].title {
            cell.setup(image: image, title: title)
        }
        return cell
    }
}

