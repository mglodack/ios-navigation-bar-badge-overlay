//
//  PushedViewControllerWithBadgeViewController.swift
//  NavigationBarBadgeOverlay
//
//  Created by Mathew Glodack on 6/3/19.
//  Copyright © 2019 glodack. All rights reserved.
//

import UIKit

class PushedViewControllerWithBadgeViewController: UIViewController {

    var buttonWithBadge: UIButtonWithBadge?
    var backBarButtonItem: UIBarButtonItem?
    
    var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        let button = UIButtonWithBadge()
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        self.buttonWithBadge = button
        
        self.backBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem
        
        self.button = UIButton(type: .system)
        self.button?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.button?.setTitle("Click me", for: .normal)
        self.button?.addTarget(self, action: #selector(clickMe), for: .touchUpInside)
        self.button?.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.button!)
        
        self.view.addConstraints([
            self.button!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.button!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc fileprivate func clickMe() {
        self.buttonWithBadge?.updateBadgeText(text: "112k")
        
        if let buttonWithBadge = self.buttonWithBadge {
            self.backBarButtonItem?.width = buttonWithBadge.desiredWidth
        }
    }
    
    @objc fileprivate func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let buttonWithBadge = self.buttonWithBadge {
            buttonWithBadge.viewDidLayoutSubviews()
            
            self.backBarButtonItem?.width = buttonWithBadge.desiredWidth
        }
    }
}
