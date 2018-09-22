//
//  NavigationBaseVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-08.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class NavigationBaseVC: BaseVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.primaryApp
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}
