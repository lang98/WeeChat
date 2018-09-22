//
//  SplashVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-30.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class SplashVC: NavigationBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UDSM.user == nil {
            let vc = LoginVC()
            vc.delegate = self
            
            let nc = UINavigationController(rootViewController: vc)
            self.addChildViewController(nc)
            self.view.addSubview(nc.view)
            nc.didMove(toParentViewController: self)
        } else {
            let vc = HomeTabsVC()
            vc.sdelegate = self
            
            let nc = UINavigationController(rootViewController: vc)
            self.addChildViewController(nc)
            self.view.addSubview(nc.view)
            nc.didMove(toParentViewController: self)
        }
        
    }
    
    func createTabBarController() -> UITabBarController {
        let chatOverviewVC = ChatOverviewVC()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [chatOverviewVC]
        return tabBarController
    }
}

extension SplashVC: LoginVCDelegate {
    
    func loginVC(_ loginVC: LoginVC, loginSuccessful success: Bool) {
        guard success else {
            return
        }
        
        let vc = HomeTabsVC()
        vc.sdelegate = self
        let nc = UINavigationController(rootViewController: vc)
        nc.view.alpha = 0.0
        
        self.addChildViewController(nc)
        self.view.addSubview(nc.view)
        nc.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.6, animations: {
            nc.view.alpha = 1.0
        }) { _ in
            loginVC.navigationController?.removeFromParentViewController()
            loginVC.view.removeFromSuperview()
        }
    }
}

extension SplashVC: HomeTabsVCDelegate {
    
    func homeTabsVC(_ homeVC: HomeTabsVC, logoutSuccessful success: Bool) {
        guard success else {
            return
        }
        
        let vc = LoginVC()
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        nc.view.alpha = 0.0
        
        self.addChildViewController(nc)
        self.view.addSubview(nc.view)
        nc.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.6, animations: {
            nc.view.alpha = 1.0
        }) { _ in
            homeVC.navigationController?.removeFromParentViewController()
            homeVC.view.removeFromSuperview()
        }
    }
    
}
