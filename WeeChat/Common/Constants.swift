
//
//  Constants.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-31.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Size {
        static let heightTextField: CGFloat = 52
        static let heightCustomButton: CGFloat = 52
        static let marginChatCellView: CGFloat = 10
        static let heightChatCellView: CGFloat = 70
        static let chatBubbleMargin: CGFloat = 20
    }
    
    struct Tab {
        static let chat: String = NSLocalizedString("Chat", comment: "")
        static let contacts: String = NSLocalizedString("Contacts", comment: "")
        static let discover: String = NSLocalizedString("Discover", comment: "")
        static let me: String = NSLocalizedString("Me", comment: "")
    }
}
