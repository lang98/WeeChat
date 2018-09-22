//
//  MenuRowCell.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-26.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class MenuRowCell: UITableViewCell {
    
    var iconView: UIImageView!
    var labelView: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        iconView = UIImageView()
        iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconView)
        
        labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.textColor = UIColor.black
        labelView.font = UIFont.title
        contentView.addSubview(labelView)
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|-(10)-[icon]-(20)-[title]|",
            options: [],
            metrics: nil,
            views: ["icon": iconView, "title": labelView]))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(10)-[icon]-(10)-|",
            options: [],
            metrics: nil,
            views: ["icon" : iconView]))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[title]|",
            options: [],
            metrics: nil,
            views: ["title" : labelView]))
        
        iconView.addConstraint(NSLayoutConstraint(
            item: iconView, attribute: .width,
            relatedBy: .equal,
            toItem: iconView, attribute: .height,
            multiplier: 1, constant: 0))
    }
    
    func setup(image: UIImage, title: String) {
        iconView.image = image
        labelView.text = title
    }
}
