//
//  UserDataSM.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-07-31.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation

let UDSM = UserDataSM.sharedManager

final class UserDataSM {
    
    // MARK: - Instance
    
    static let sharedManager = UserDataSM()
    
    // MARK: - Properties
    
    var user: UserInfo? {
        get {
            if let dic = UserDefaults.standard.value(forKey: "user") as? [String : Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dic)
                    return try JSONDecoder().decode(UserInfo.self, from: jsonData)
                } catch {
                    
                }
            }
            return nil
        }
        
        set {
            if let value = newValue {
                UserDefaults.standard.set(value.dictionary, forKey: "user")
            } else {
                UserDefaults.standard.set(nil, forKey: "user")
            }
        }
    }
    
    func clearUserData() {
        UDSM.user = nil
    }
}
