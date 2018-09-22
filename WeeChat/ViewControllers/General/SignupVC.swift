//
//  SignupViewController.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-18.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import UIKit
import Firebase

internal class SC: BaseVC {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBAction func onBackToLoginPress(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
