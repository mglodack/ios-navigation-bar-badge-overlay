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
    var backBarButtonView: UIView?
    
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
        
        self.badgeLabel = insetLabel
        badgeLabel?.text = "10000"
        badgeLabel?.backgroundColor = .white
        badgeLabel?.textColor = .red
        badgeLabel?.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel?.textAlignment = .center
        badgeLabel?.layer.masksToBounds = true
        badgeLabel?.numberOfLines = 1
        
        let backButtonView = UIView()
        backButtonView.backgroundColor = .orange
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        backButtonView.isUserInteractionEnabled = false
        
        // Add chevron + label to UIView
        backButtonView.addSubview(imageView)
        backButtonView.addSubview(label)
        backButtonView.addSubview(badgeLabel!)
        
        self.backBarButtonView = backButtonView

        label.contentHuggingPriority(for: .vertical)

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
            
            badgeLabel!.heightAnchor.constraint(lessThanOrEqualToConstant: 25),
            
            badgeLabel!.topAnchor.constraint(equalTo: label.topAnchor),
            badgeLabel!.bottomAnchor.constraint(equalTo: label.bottomAnchor)
            ])
        
        backButtonView.sizeToFit()
        
        // Create custom UIButton for UIBarButtonItme(customView: ...)
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        button.addSubview(backButtonView)
        button.contentMode = .center
        button.isUserInteractionEnabled = true

        button.addConstraints([
            backButtonView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            backButtonView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            backButtonView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            backButtonView.topAnchor.constraint(equalTo: button.topAnchor)
            ])

        button.translatesAutoresizingMaskIntoConstraints = false
        self.backButton = button
        
        self.backBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem
    }
    
    @objc public func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let backView = self.backBarButtonView, let lastView = backView.subviews.last, let backButton = self.backButton {
            
            backButton.frame.size.width = lastView.frame.origin.x + lastView.frame.width
            
            self.backBarButtonItem?.width = backButton.frame.size.width
        }
        
        if let badge = self.badgeLabel {
            badge.layer.cornerRadius = badge.frame.size.width / 2
        }
    }
}
