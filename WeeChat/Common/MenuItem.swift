//
//  MenuItem.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-09-05.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

struct MenuItem {
    
    var image: UIImage?
    var title: String?
    
    init(image: UIImage?, title: String?) {
        self.image = image
        self.title = title
    }
}
