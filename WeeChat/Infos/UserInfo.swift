//
//  UserInfo.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-31.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation

class UserInfo: Codable {
    var email: String?
    var name: String?
    var id: String?
    
    init(email: String, name: String, id: String) {
        self.email = email
        self.name = name
        self.id = id
    }
    
    private enum CodingKeys: String, CodingKey {
        case email
        case name
        case id
    }
}
