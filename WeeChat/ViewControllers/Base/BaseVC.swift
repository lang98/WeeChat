//
//  BaseVC.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-31.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
    
    // MARK: - Helper Methods: Display Message Dialog
    
    internal func displayMessageDialog(message: String, title: String = "", completion: (() -> Swift.Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { (action) in
            if let _completion = completion {
                _completion()
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    internal func displayNetworkErrorMessageDialog() {
        self.displayMessageDialog(message: NSLocalizedString("HttpNetworkError", comment: ""))
    }
}
