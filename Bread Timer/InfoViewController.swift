//
//  InfoViewController.swift
//  Bread Timer
//
//  Created by Tim Darragh on 5/26/20.
//  Copyright © 2020 Tim Darragh. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Always adopt a light interface style.
        overrideUserInterfaceStyle = .light
        
        // Default Back Button
        if let topItem = self.navigationController?.navigationBar.topItem {
           topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}
