//
//  ViewController.swift
//  TaskIt
//
//  Created by Darryl Pendergrass on Oct/3/15.
//  Copyright © 2015 Phoenix Media Services, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //var taskArray:[TaskModel] = []
    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let date1 = Date.from(year: 2014, month: 05, day: 20)
        let date2 = Date.from(year: 2014, month: 03, day: 3)
        let date3 = Date.from(year: 2014, month: 12, day: 13)
        
        let task1 = TaskModel(task: "Study French", subtask: "Verbs", date: date1, isCompleted: false)
        let task2 = TaskModel(task: "Eat Dinner", subtask: "Burgers", date: date2, isCompleted: false)
        let task3 = TaskModel(task: "Gym", subtask: "Leg day", date: date3, isCompleted: false)
        

        let taskArray = [task1, task2, task3]
        
        let completedTaskArray = [TaskModel(task: "Code", subtask: "TaskIt Project", date:date2, isCompleted:true)]
        
        baseArray = [taskArray, completedTaskArray]
        
        //Sort taskArray using closure
//        baseArray[0] = baseArray[0].sort {
//            (task1: TaskModel, task2: TaskModel) -> Bool in
//            return task1.date.timeIntervalSince1970 < task2.date.timeIntervalSince1970
//        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
  
        //Sort taskArray using closure
        baseArray[0] = baseArray[0].sort {
            (task1: TaskModel, task2: TaskModel) -> Bool in
            return task1.date.timeIntervalSince1970 < task2.date.timeIntervalSince1970
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
//        if segue.identifier == "showTaskDetail" {
//            let detailVC: TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
//            let indexPath = self.tableView.indexPathForSelectedRow!
//            let thisTask = taskArray[indexPath.row]
//            detailVC.detailTaskModel = thisTask
//        }
        
        if segue.destinationViewController is TaskDetailViewController {
          let taskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            taskDetailViewController.detailTaskModel = baseArray[(tableView.indexPathForSelectedRow?.section)!][(tableView.indexPathForSelectedRow?.row)!]
            taskDetailViewController.mainVC = self
        }
        else if segue.destinationViewController is AddTaskViewController {
            let addTaskViewController = segue.destinationViewController as! AddTaskViewController
            addTaskViewController.mainVC = self
            
        }
    }
    
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! TaskCell
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        cell.taskLabel.text = thisTask.task
        cell.subtaskLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "To do"
        }
        else{
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
        let newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, isCompleted: true)
        baseArray[1].append(newTask)
        }
        else{
            let newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, isCompleted: false)
            baseArray[0].append(newTask)
        }
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
}

