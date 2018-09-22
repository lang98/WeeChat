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
    
    init(email: String, name: String) {
        self.email = email
        self.name = name
    }
    
    private enum CodingKeys: String, CodingKey {
        case email
        case name
    }
}
