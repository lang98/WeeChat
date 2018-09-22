//
//  ChatBubbleView.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-19.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class ChatBubbleView: UIView {
    
    var isIncoming = false
    
    var incomingColor = UIColor.secondaryBackground
    var outgoingColor = UIColor.primaryGreen
    
    let cellRadius: CGFloat = 10
    let bezierCubic: CGFloat = 3
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let bezierPath = UIBezierPath()
        
        if isIncoming {
            bezierPath.move(to: CGPoint(x: cellRadius, y: height))
            bezierPath.addLine(to: CGPoint(x: width - cellRadius, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height - cellRadius), controlPoint1: CGPoint(x: width - bezierCubic, y: height), controlPoint2: CGPoint(x: width, y: height - bezierCubic))
            bezierPath.addLine(to: CGPoint(x: width, y: cellRadius))
            bezierPath.addCurve(to: CGPoint(x: width - cellRadius, y: 0), controlPoint1: CGPoint(x: width, y: bezierCubic), controlPoint2: CGPoint(x: width - bezierCubic, y: 0))
            bezierPath.addLine(to: CGPoint(x: cellRadius, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 0, y: cellRadius), controlPoint1: CGPoint(x: bezierCubic, y: 0), controlPoint2: CGPoint(x: 0, y: bezierCubic))
            bezierPath.addLine(to: CGPoint(x: 0, y: height - cellRadius))
            bezierPath.addCurve(to: CGPoint(x: cellRadius, y: height), controlPoint1: CGPoint(x: 0, y: height - bezierCubic), controlPoint2: CGPoint(x: bezierCubic, y: height))
            
            incomingColor.setFill()
            
        } else {
            bezierPath.move(to: CGPoint(x: cellRadius, y: height))
            bezierPath.addLine(to: CGPoint(x: width - cellRadius, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height - cellRadius), controlPoint1: CGPoint(x: width - bezierCubic, y: height), controlPoint2: CGPoint(x: width, y: height - bezierCubic))
            bezierPath.addLine(to: CGPoint(x: width, y: cellRadius))
            bezierPath.addCurve(to: CGPoint(x: width - cellRadius, y: 0), controlPoint1: CGPoint(x: width, y: bezierCubic), controlPoint2: CGPoint(x: width - bezierCubic, y: 0))
            bezierPath.addLine(to: CGPoint(x: cellRadius, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 0, y: cellRadius), controlPoint1: CGPoint(x: bezierCubic, y: 0), controlPoint2: CGPoint(x: 0, y: bezierCubic))
            bezierPath.addLine(to: CGPoint(x: 0, y: height - cellRadius))
            bezierPath.addCurve(to: CGPoint(x: cellRadius, y: height), controlPoint1: CGPoint(x: 0, y: height - bezierCubic), controlPoint2: CGPoint(x: bezierCubic, y: height))
            
            outgoingColor.setFill()
        }
        
        bezierPath.close()
        bezierPath.fill()
    }
    
}
