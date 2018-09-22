//
//  Utility.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-03.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

struct Utility {
    struct View {
        static func shiftTextFieldUp(textField: UITextField, containerView: UIView, scrollView: UIScrollView, keyboardHeight: CGFloat) {
            let offsetY = textField.convert(textField.frame.origin, to: containerView).y - textField.frame.height - keyboardHeight * 2
            if scrollView.contentOffset.y < offsetY {
                scrollView.contentOffset.y = offsetY
            }
        }
    }
}
