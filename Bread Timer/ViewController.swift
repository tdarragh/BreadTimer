//
//  ViewController.swift
//  Bread Timer
//
//  Created by Tim Darragh on 5/24/20.
//  Copyright © 2020 Tim Darragh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, ChangeButton {

    var tasks: [Task] = []
    
    var minutes = 90
    var timer = Timer()
    var audioPlayer = AVAudioPlayer()

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: SLIDER Outlet & Action
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBAction func slider(_ sender: UISlider) {
        minutes = Int(sender.value)
        label.text = String(minutes)
    }
    
    // MARK: "until next step" PLACEHOLDER
    @IBOutlet weak var untilNextStep: UILabel!
    
    
    // MARK: TIMER START Outlet & Action
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func start(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        sliderOutlet.isHidden = true
        startOutlet.isHidden = true
        untilNextStep.isHidden = false
        
    }
    // MARK: WHEN TIMER IS DONE
    @objc func counter() {
        minutes -= 1
        label.text = String(minutes)
        if (minutes == 0) {
            timer.invalidate()
        sliderOutlet.isHidden = true
        startOutlet.isHidden = true
        audioPlayer.play()
        audioPlayer.numberOfLoops = -1
        }
    }
    
    // MARK: TIMER STOP
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func Stop(_ sender: Any) {
        timer.invalidate()
        minutes = 90
        sliderOutlet.setValue(90, animated: true)
        label.text = "90"
        audioPlayer.stop()
        sliderOutlet.isHidden = false
        startOutlet.isHidden = false
        untilNextStep.isHidden = true
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        
        // Always adopt a light interface style.
        overrideUserInterfaceStyle = .light
        
        untilNextStep.isHidden = true
        
        // Appended Tasks
        tasks.append(Task(name: "tap circle to check off"))
        tasks.append(Task(name: "swipe left to delete"))
        
        //Audio Player
        do {
            let audioPath = Bundle.main.path(forResource: "tone", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch {
            //ERROR
        }
    }
    
    
    @IBAction func info(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        
        if tasks[indexPath.row].checked {
            cell.checkBoxOutlet.setBackgroundImage(UIImage.init(named: "circleFilled"), for: UIControl.State.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(UIImage.init(named: "circle"), for: UIControl.State.normal)
        }
        
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.tasks = tasks
        
        return cell
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ViewController = segue.destination as! AddTaskController
        ViewController.delegate = self
        
    }
    
    // MARK: Swipe to delete here
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            self.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        
        deleteAction.backgroundColor = UIColor(red: 1, green: 0.326, blue: 0.326, alpha: 1.00)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UIContextualAction]? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _,_  in
            self.tasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = UIColor(red: 1, green: 0.326, blue: 0.283, alpha: 1)
        return [deleteAction]
    }
    
    func addTask(name: String) {
        tasks.append(Task(name: name))
        tableView.reloadData()
    }
    
    func changeButton(checked: Bool, index: Int) {
        tasks[index].checked = checked
        tableView.reloadData()
    }
}

class Task {
    var name = ""
    var checked = false
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

