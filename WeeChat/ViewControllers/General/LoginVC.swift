//
//  ViewController.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-04.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

protocol LoginVCDelegate: class {
    
    func loginVC(_ loginVC: LoginVC, loginSuccessful success: Bool)
    
}

class LoginVC: FullscreenVC {
    
    // MARK: - Properties
    
    private var keyboardHeight: CGFloat = 0
    private var scrollUpHeight: CGFloat = 0

    weak var delegate: LoginVCDelegate?
    
    // MARK: - Controls
    private var scrollView: UIScrollView!
    private var containerView: UIView!
    
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = true
        self.renderContainer()
        self.renderContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private func renderContainer() {
        // Scroll
        scrollView = UIScrollView()
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        // Container
        containerView = UIView()
        containerView.frame = self.view.bounds
        scrollView.addSubview(containerView)
        
        // Scroll
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[scroll]|",
                                                                options: [],
                                                                metrics: nil,
                                                                views: ["scroll": scrollView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scroll]|",
                                                                options: [],
                                                                metrics: nil,
                                                                views: ["scroll": scrollView]))
    }
    
    private func renderContent() {
        let textFieldFrame = CGRect(x: 0, y: 0, width: Constants.Size.heightTextField, height: Constants.Size.heightTextField)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentView)
        
        emailTextField = UITextField(frame: textFieldFrame)
        emailTextField.delegate = self
        emailTextField.placeholder = NSLocalizedString("Email Address", comment: "")
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailTextField)
        
        passwordTextField = UITextField(frame: textFieldFrame)
        passwordTextField.delegate = self
        passwordTextField.placeholder = NSLocalizedString("Password", comment: "")
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(passwordTextField)
        
        signInButton = UIButton(frame: textFieldFrame)
        signInButton.setTitle(NSLocalizedString("Sign in", comment: ""), for: .normal)
        signInButton.backgroundColor = UIColor.primaryApp
        signInButton.addTarget(self, action: #selector(self.signInAction), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signInButton)
        
        // Content
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(30)-[content]-(30)-|", options: [], metrics: nil, views: ["content" : contentView]))
        containerView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
        
        // Email
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[email]|",
            options: [],
            metrics: nil,
            views: ["email" : emailTextField]))
        emailTextField.addConstraint(NSLayoutConstraint(
            item: emailTextField, attribute: .height,
            relatedBy: .equal,
            toItem: nil, attribute: .height,
            multiplier: 1, constant: textFieldFrame.size.height))
        
        // Password
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[password]|",
            options: [],
            metrics: nil,
            views: ["password" : passwordTextField]))
        passwordTextField.addConstraint(NSLayoutConstraint(
            item: passwordTextField, attribute: .height,
            relatedBy: .equal,
            toItem: nil, attribute: .height,
            multiplier: 1, constant: textFieldFrame.size.height))
        
        // Sign in
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[signIn]|",
            options: [],
            metrics: nil,
            views: ["signIn" : signInButton]))
        signInButton.addConstraint(NSLayoutConstraint(
            item: signInButton, attribute: .height,
            relatedBy: .equal,
            toItem: nil, attribute: .height,
            multiplier: 1, constant: textFieldFrame.size.height))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[email]-(20)-[password]-(20)-[signIn]|",
            options: [],
            metrics: nil,
            views: ["email": emailTextField, "password": passwordTextField, "signIn": signInButton]))
        
        containerView.layoutIfNeeded()
        
        if #available(iOS 11.0, *) {
            self.scrollUpHeight = containerView.frame.maxY - contentView.frame.maxY - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0)
        } else {
            self.scrollUpHeight = containerView.frame.maxY - contentView.frame.maxY
        }
    }
    
    @objc func signInAction() {
        self.view.endEditing(true)
        emailTextField.text = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        
        guard let email = emailTextField.text, !email.isEmpty else {
            self.displayMessageDialog(message: NSLocalizedString("You must enter all fields", comment: ""))
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            self.displayMessageDialog(message: NSLocalizedString("You must enter all fields", comment: ""))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                UDSM.user = UserInfo(email: email, name: "User")
                AppDelegate.delegate.showMainScreen()
            }
        }
    }
    
    @objc func editingChanged() {
        
    }
    
    // MARK: - NSNotificationCenter
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let textField = emailTextField else {
            return
        }
        
        if let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardHeight = keyboardRect.height
            Utility.View.shiftTextFieldUp(textField: textField, containerView: self.containerView, scrollView: self.scrollView, keyboardHeight: self.keyboardHeight)
            self.scrollView.contentSize.height = self.containerView.frame.height + self.keyboardHeight
            self.scrollView.contentOffset.y = self.scrollUpHeight
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            UIView.animate(withDuration: 0.2, animations: {
                self.scrollView.contentSize.height = self.containerView.frame.height
            })
        }
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            if signInButton.isEnabled {
                self.signInAction()
            }
        }
        return true
    }
}

