//
//  PushedViewControllerWithBadgeViewController.swift
//  NavigationBarBadgeOverlay
//
//  Created by Mathew Glodack on 6/3/19.
//  Copyright © 2019 glodack. All rights reserved.
//

import UIKit

class PushedViewControllerWithBadgeViewController: UIViewController {

    var backButton: UIButton?
    var backBarButtonItem: UIBarButtonItem?
    var badgeLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        let imageView = UIImageView(image: UIImage(named: "chevron_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Hello"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.layer.masksToBounds = true
        
        let insetLabel = InsetUILabel()
        insetLabel.contentInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        self.badgeLabel = insetLabel
        badgeLabel?.text = "100"
        badgeLabel?.backgroundColor = .white
        badgeLabel?.textColor = .red
        badgeLabel?.sizeToFit()
        badgeLabel?.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel?.textAlignment = .center
        badgeLabel?.layer.masksToBounds = true
        badgeLabel?.numberOfLines = 1
        badgeLabel?.minimumScaleFactor = 0.5
        badgeLabel?.adjustsFontSizeToFitWidth = true
        
        let backButtonView = UIView()
        backButtonView.backgroundColor = .clear
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add chevron + label to UIView
        backButtonView.addSubview(imageView)
        backButtonView.addSubview(label)
        backButtonView.addSubview(badgeLabel!)
        
        // Add constraints for chevron + label within UIView
        backButtonView.addConstraints([
            // UIImageView constraints
            imageView.leadingAnchor.constraint(equalTo: backButtonView.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: backButtonView.centerYAnchor),
            
            // UILabel text constraints
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 3),
            label.centerYAnchor.constraint(equalTo: backButtonView.centerYAnchor),
            
            // UILabel badge constraints
            badgeLabel!.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 3),
            badgeLabel!.widthAnchor.constraint(equalTo: badgeLabel!.heightAnchor),
            
            badgeLabel!.topAnchor.constraint(equalTo: label.topAnchor),
            badgeLabel!.bottomAnchor.constraint(equalTo: label.bottomAnchor)
            ])
        
        backButtonView.sizeToFit()
        
        // Create custom UIButton for UIBarButtonItme(customView: ...)
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        button.addSubview(backButtonView)
        
        button.addConstraints([
            button.leadingAnchor.constraint(equalTo: backButtonView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: backButtonView.trailingAnchor),
            button.topAnchor.constraint(equalTo: backButtonView.topAnchor),
            button.bottomAnchor.constraint(equalTo: backButtonView.bottomAnchor),
            ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.backButton = button
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        self.backBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem
    }
    
    @objc public func navigateBack() {
        print("back")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.backButton?.layoutIfNeeded()
        
        if let badge = self.badgeLabel {
            badge.layer.cornerRadius = badge.frame.size.width / 2
        }
    }
}
