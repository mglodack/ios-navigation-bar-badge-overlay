//
//  UIButtonWithBadge.swift
//  NavigationBarBadgeOverlay
//
//  Created by Mathew Glodack on 6/3/19.
//  Copyright © 2019 glodack. All rights reserved.
//

import Foundation
import UIKit

public final class UIButtonWithBadge: UIButton {
    
    let badgeLabel: UILabel
    
    required init() {
        self.badgeLabel = UIButtonWithBadge.createBadgeLabel()
        
        super.init(frame: .zero)
        
        self.contentMode = .center
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIButtonWithBadge.createCustomView(self.badgeLabel)
        self.addSubview(view)
        
        self.addConstraints([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor)
            ])
    }
    
    public var desiredWidth: CGFloat {
        let frame = badgeLabel.frame
        
        return frame.origin.x + frame.width
    }
    
    public func viewDidLayoutSubviews() {
        self.frame.size.width = self.desiredWidth
        
        badgeLabel.layer.cornerRadius = badgeLabel.frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate static func createCustomView(_ badgeLabel: UILabel) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false

        let imageView = UIButtonWithBadge.createImageView()
        let titleLabel = UIButtonWithBadge.createTitleLabel("Songs")
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(badgeLabel)
        
        // Add constraints for chevron + label + badge within UIView
        view.addConstraints([
            // UIImageView constraints
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // UILabel title constraints
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 3),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // UILabel badge constraints
            badgeLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 3),
            badgeLabel.widthAnchor.constraint(equalTo: badgeLabel.heightAnchor),
            
            badgeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40),
            
            badgeLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            badgeLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
            ])
        
        return view
    }
    
    fileprivate static func createImageView() -> UIImageView {
        let imageView = UIImageView(
            image: UIImage(named: "chevron_icon")
        )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    fileprivate static func createTitleLabel(_ title: String) -> UILabel {
        let label = UILabel()
        
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.layer.masksToBounds = true
        
        return label
    }
    
    fileprivate static func createBadgeLabel() -> UILabel {
        let insetLabel = InsetUILabel()
        insetLabel.contentInsets = UIEdgeInsets(
            top: 2,
            left: 2,
            bottom: 2,
            right: 2)
        
        insetLabel.text = "111k"
        insetLabel.backgroundColor = .white
        insetLabel.textColor = .red
        insetLabel.translatesAutoresizingMaskIntoConstraints = false
        insetLabel.textAlignment = .center
        insetLabel.layer.masksToBounds = true
        insetLabel.numberOfLines = 1
        insetLabel.font = insetLabel.font.withSize(12)
        
        return insetLabel
    }
}
