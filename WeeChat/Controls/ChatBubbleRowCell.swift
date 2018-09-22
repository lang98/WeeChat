//
//  ChatBubbleRow.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-19.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class ChatBubbleRowCell: UITableViewCell {
    
    var isIncoming = false
    
    private var messageLabel: UILabel!
    private var bubbleView: ChatBubbleView!
    
    var message: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    func showMessage() {
        isIncoming ? showIncomingMessage(text: message ?? "") : showOutgoingMessage(text: message ?? "")
    }
    
    private func showIncomingMessage(text: String) {
        // message
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.textColor = .black
        messageLabel.text = text
        contentView.addSubview(messageLabel)
        
        let constraintRect = CGSize(width: 0.66 * contentView.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: messageLabel.font],
                                            context: nil)
        messageLabel.frame.size = CGSize(width: ceil(boundingBox.width),
                                         height: ceil(boundingBox.height))
        
        // bubble
        let bubbleSize = CGSize(width: messageLabel.frame.width + 28,
                                height: messageLabel.frame.height + 20)
        
        bubbleView = ChatBubbleView()
        bubbleView.isIncoming = true
        bubbleView.frame.size = bubbleSize
        bubbleView.backgroundColor = .clear
        bubbleView.frame.origin.x = Constants.Size.chatBubbleMargin
        contentView.addSubview(bubbleView)
        
        messageLabel.center.x = bubbleView.center.x
        messageLabel.center.y = bubbleView.center.y
        contentView.bringSubview(toFront: messageLabel)
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[bubbleView]|",
            options: [],
            metrics: nil,
            views: ["bubbleView": bubbleView]))
    }
    
    private func showOutgoingMessage(text: String) {

        // message
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.textColor = .white
        messageLabel.text = text
        contentView.addSubview(messageLabel)
        
        let constraintRect = CGSize(width: 0.66 * contentView.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: messageLabel.font],
                                            context: nil)
        messageLabel.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        // bubble
        let bubbleSize = CGSize(width: messageLabel.frame.width + 28,
                                height: messageLabel.frame.height + 20)
        
        bubbleView = ChatBubbleView()
        bubbleView.frame.size = bubbleSize
        bubbleView.backgroundColor = .clear
        
        bubbleView.frame.origin.x = UIScreen.main.bounds.width - bubbleView.frame.width - Constants.Size.chatBubbleMargin
        contentView.addSubview(bubbleView)
        
        messageLabel.center.x = bubbleView.center.x
        messageLabel.center.y = bubbleView.center.y
        contentView.bringSubview(toFront: messageLabel)
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[bubbleView]|",
            options: [],
            metrics: nil,
            views: ["bubbleView": bubbleView]))
        
    }
}
