//
//  AppDelegate.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-04.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Main controller
        window = UIWindow(frame: UIScreen.main.bounds)
        showMainScreen()
        setTheme()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    public static var delegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func showMainScreen() {
        window?.rootViewController = UINavigationController(rootViewController: HomeTabsVC())
    }
    
    func showLoginScreen() {
        window?.rootViewController = UINavigationController(rootViewController: LoginVC())
    }
    
    func setTheme() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.navigationBar.barTintColor = UIColor.primaryApp
            navigationController.navigationBar.isTranslucent = true
            navigationController.navigationBar.tintColor = UIColor.white
            navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }

}

