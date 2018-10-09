//
//  ChatInfo.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-09-27.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation

class ChatInfo: Codable {
    
    var title: String?
    var senderId: String?
    var preview: String?
    var chatId: String?
    
    init(title: String, senderId: String, preview: String, chatId: String) {
        self.title = title
        self.senderId = senderId
        self.preview = preview
        self.chatId = chatId
    }
    
    init?(dictionary: [String: Any], id: String) {
        guard let chatId = dictionary["id"] as? String else {
            return
        }
        self.chatId = chatId
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case senderId
        case preview
    }
}
