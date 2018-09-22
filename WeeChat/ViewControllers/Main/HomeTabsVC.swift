//
//  HomeVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-09.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

protocol HomeTabsVCDelegate: class {
    
    func homeTabsVC(_ homeVC: HomeTabsVC, logoutSuccessful success: Bool)
}

class HomeTabsVC: UITabBarController {
    
    weak var sdelegate: HomeTabsVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBarController()
        
        // init to first tab
        self.selectedIndex = 0
        self.title = Constants.Tab.chat
        self.tabBar.tintColor = UIColor.primaryGreen
    }
    
    func createTabBarController() {
        
        let chatVC = ChatOverviewVC()
        chatVC.tabBarItem = UITabBarItem.init(title: Constants.Tab.chat, image: UIImage(named: "Chat"), tag: 0)
        
        let contactVC = ContactsVC()
        contactVC.tabBarItem = UITabBarItem.init(title: Constants.Tab.contacts, image: UIImage(named: "Contacts"), tag: 0)
        
        let discoverVC = DiscoverVC()
        discoverVC.tabBarItem = UITabBarItem.init(title: Constants.Tab.discover, image: UIImage(named: "Discover"), tag: 0)
        
        let meVC = MeVC()
        meVC.tabBarItem = UITabBarItem.init(title: Constants.Tab.me, image: UIImage(named: "Me"), tag: 0)
        
        let controllerArray = [chatVC, contactVC, discoverVC, meVC]
        self.viewControllers = controllerArray
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = item.title
    }
}
