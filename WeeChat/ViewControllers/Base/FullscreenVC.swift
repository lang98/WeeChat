//
//  FullscreenVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-02.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class FullscreenVC: BaseVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
