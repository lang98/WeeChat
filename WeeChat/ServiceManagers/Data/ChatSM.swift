//
//  ChatSM.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-09-25.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

let CSM = ChatSM.sharedManager

class ChatSM {
    
    static let sharedManager = UserDataSM()
    
    private var ref = Firestore.firestore().collection("chats")
    
    func addChat(userId: String) {
        
    }
    
}
