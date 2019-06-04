//
//  ViewController.swift
//  NavigationBarBadgeOverlay
//
//  Created by Mathew Glodack on 6/3/19.
//  Copyright © 2019 glodack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var pushButton: UIButton!
    @IBOutlet var pushDefaultButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        
        self.pushButton.addTarget(self, action: #selector(pushVc), for: .touchUpInside)
        
        self.pushDefaultButton.addTarget(self, action: #selector(pushDefaultVc), for: .touchUpInside)
    }
    
    @objc fileprivate func pushVc() {
        let vc = PushedViewControllerWithBadgeViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func pushDefaultVc() {
        let vc = EmptyViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

