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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        let button = UIButtonWithBadge()
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        self.buttonWithBadge = button
        
        self.backBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem
    }
    
    @objc public func navigateBack() {
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
