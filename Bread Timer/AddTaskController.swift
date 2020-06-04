//
//  AddTaskController.swift
//  Bread Timer
//
//  Created by Tim Darragh on 5/24/20.
//  Copyright © 2020 Tim Darragh. All rights reserved.
//

import UIKit
import Lottie

protocol AddTask {
    func addTask(name: String)
}

class AddTaskController: UIViewController {


    @IBOutlet weak var animationView: AnimationView!
    
    @IBAction func addAction(_ sender: Any) {
        if taskNameOutlet.text != "" {
            delegate?.addTask(name: taskNameOutlet.text!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBOutlet var taskNameOutlet: UITextField!
    
    var delegate: AddTask?
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        // super.viewDidLoad()
        startAnimation()
        
        
        
        // Always adopt a light interface style.
        overrideUserInterfaceStyle = .light
        
        // Default Back Button
        if let topItem = self.navigationController?.navigationBar.topItem {
           topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            
        }
        
    }
    
    func startAnimation() {
        animationView.animation = Animation.named("loafyAnim")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
}
