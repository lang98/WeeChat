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
    var sendTime: String?
    var senderId: String?
    var senderName: String?
    
    init(_ content: String, _ sendTime: String, _ senderId: String, _ senderName: String) {
        self.content = content
        self.sendTime = sendTime
        self.senderId = senderId
        self.senderName = senderName
    }
    
    private enum CodingKeys: String, CodingKey {
        case content
        case sendTime
        case senderId
        case senderName
    }
}
