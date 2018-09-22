//
//  ChatTableViewCell.swift
//  WeeChat
//
//  Created by Ryan Qin on 2018-08-06.
//  Copyright © 2018 Ryan Qin. All rights reserved.
//

import Foundation
import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var containerView: UIView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var userImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView = UIView()
        containerView.tintColor = UIColor.red
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.title
        containerView.addSubview(titleLabel)
        
        subTitleLabel = UILabel()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.textColor = UIColor.black
        subTitleLabel.font = UIFont.subTitle
        containerView.addSubview(subTitleLabel)
        
        userImage = UIImageView(image: UIImage(named: "UserLogo"))
        userImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(userImage)
        
        // Container
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|-(margin)-[container]-(margin)-|",
            options: [],
            metrics: ["margin": Constants.Size.marginChatCellView],
            views: ["container": containerView]))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(margin)-[container]-(margin)-|",
            options: [],
            metrics: ["margin": Constants.Size.marginChatCellView],
            views: ["container": containerView]))
        
        containerView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[logo]-(10)-[title]|",
            options: [],
            metrics: nil,
            views: ["logo": userImage, "title": titleLabel]))
        
        containerView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[logo]-(10)-[subtitle]|",
            options: [],
            metrics: nil,
            views: ["logo": userImage, "subtitle": subTitleLabel]))
        
        containerView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[title]-[subtitle]|",
            options: [],
            metrics: nil,
            views: ["title": titleLabel, "subtitle": subTitleLabel]))
        
        containerView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[logo]|",
            options: [],
            metrics: nil,
            views: ["logo" : userImage]))
        
        userImage.addConstraint(NSLayoutConstraint(
            item: userImage, attribute: .width,
            relatedBy: .equal,
            toItem: userImage, attribute: .height,
            multiplier: 1, constant: 0))
    }
}
