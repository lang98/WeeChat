//
//  ChatInfo.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-06.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation

class MessageInfo: Codable {
    
    var content: String?
    var senderId: String?
    var senderName: String?
    
    init(content: String, senderId: String, senderName: String) {
        self.content = content
        self.senderId = senderId
        self.senderName = senderName
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let content = dictionary["content"] as? String else {
            return nil
        }
        guard let senderId = dictionary["senderId"] as? String else {
            return nil
        }
        guard let senderName = dictionary["senderName"] as? String else {
            return nil
        }
        self.init(content: content, senderId: senderId, senderName: senderName)
    }
    
    private enum CodingKeys: String, CodingKey {
        case content
        case senderId
        case senderName
    }
}
