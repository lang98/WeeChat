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
    var preview: String?
    var chatId: String?
    
    init(title: String, preview: String, chatId: String) {
        self.title = title
        self.preview = preview
        self.chatId = chatId
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let title = dictionary["title"] as? String else {
            return nil
        }
        guard let preview = dictionary["preview"] as? String else {
            return nil
        }
        guard let chatId = dictionary["chatId"] as? String else {
            return nil
        }
        self.init(title: title, preview: preview, chatId: chatId)
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case preview
        case chatId
    }
}
