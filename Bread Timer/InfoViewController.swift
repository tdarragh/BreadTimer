//
//  InfoViewController.swift
//  Bread Timer
//
//  Created by Tim Darragh on 5/27/20.
//  Copyright © 2020 Tim Darragh. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    // TWITTER Link
    @IBAction func twitterButton(_ sender: UIButton) {
        UIApplication.shared.open(URL (string: "https://www.twitter.com/search?q=%23BreadTimerApp")! as URL, options: [:], completionHandler: nil)
    }
    
    // INSTAGRAM Link
    @IBAction func instagramButton(_ sender: UIButton) {
        UIApplication.shared.open(URL (string: "https://www.instagram.com/explore/tags/BreadTimerApp/?hl=en")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func stickerButtom(_ sender: UIButton) {
         UIApplication.shared.open(URL (string: "https://apps.apple.com/us/app/maus-cat-stickers/id1386613018")! as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func timButton(_ sender: Any) {
         UIApplication.shared.open(URL (string: "https://www.timdarragh.com")! as URL, options: [:], completionHandler: nil)
    }
    
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
