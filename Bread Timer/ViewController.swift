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
    
    // SLIDER
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBAction func slider(_ sender: UISlider) {
        minutes = Int(sender.value)
        label.text = String(minutes)
    }
    
    // TIMER START
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func start(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        sliderOutlet.isHidden = true
        startOutlet.isHidden = true
    }
    // WHEN TIMER IS DONE
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
    
    // TIMER STOP
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func Stop(_ sender: Any) {
        timer.invalidate()
        minutes = 90
        sliderOutlet.setValue(90, animated: true)
        label.text = "90"
        audioPlayer.stop()
        sliderOutlet.isHidden = false
        startOutlet.isHidden = false
    }
    
    override func viewDidLoad() {
        
        // Always adopt a light interface style.
        overrideUserInterfaceStyle = .light
        
        // Appended Tasks
        tasks.append(Task(name: "tap circle to check off"))
        tasks.append(Task(name: "swipe left to delete"))
        tasks.append(Task(name: "1"))
        tasks.append(Task(name: "2"))
        tasks.append(Task(name: "3"))
        tasks.append(Task(name: "4"))
        tasks.append(Task(name: "5"))
        tasks.append(Task(name: "6"))
        tasks.append(Task(name: "7"))
        tasks.append(Task(name: "8"))
        tasks.append(Task(name: "9"))
        tasks.append(Task(name: "10"))
        tasks.append(Task(name: "THE END"))
        
        //Audio Player
        do {
            let audioPath = Bundle.main.path(forResource: "tone", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch {
            //ERROR
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddTaskController
        vc.delegate = self
    }
    
    // Swipe to delete here
    
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

