//
//  ChatInputBox.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-10-09.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class ChatInputBox: UIView {
    
    var textInput: UITextField!
    var iconView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.secondaryGrey
        
        textInput = UITextField()
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.borderStyle = .roundedRect
        textInput.returnKeyType = .send
        self.addSubview(textInput)
        
        iconView = UIImageView()
        iconView.image = UIImage(named: "happy")
        iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconView)
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|-(10)-[input]-(10)-[icon]-(10)-|",
            options: [],
            metrics: nil,
            views: ["input": textInput, "icon": iconView]))
        
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(10)-[input]-(10)-|",
            options: [],
            metrics: nil,
            views: ["input": textInput]))
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(10)-[icon]-(10)-|",
            options: [],
            metrics: nil,
            views: ["icon": iconView]))
    }
    
    func getMessage() -> String {
        return textInput.text ?? ""
    }
    
    func clearMessage() {
        textInput.text = ""
    }
}
