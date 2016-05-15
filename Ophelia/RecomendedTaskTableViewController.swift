//
//  RecomendedTaskTableViewController.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/7/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

class RecomendedTaskTableViewController: UITableViewController {

    var sampleTasks = [RecomendedTask]()
    var checked = [Bool](count: 24, repeatedValue: false)
    let date = NSDate()
    var deadlined = NSDate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        loadSampleTasks()
//        let appDomain = NSBundle.mainBundle().bundleIdentifier!
//        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
    }

    func loadSampleTasks() {
        let prefs = NSUserDefaults.standardUserDefaults()
        let date = prefs.stringForKey("dateString")
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy MM dd HH mm a"
        deadlined = formatter.dateFromString(date!)!
        let stringDead = String(deadlined)
        print("test test \(stringDead)")
        let task1 = RecomendedTask(name: "Take  a walk", time: "Weekly", cat: "health", numOfDays: 0)
        let task2 = RecomendedTask(name: "Tidy house up", time: "Weekly", cat: "house", numOfDays: 7)
        let task3 = RecomendedTask(name: "Take out trash", time: "Weekly", cat: "house", numOfDays: 7)
        let task4 = RecomendedTask(name: "Deep clean bathroom", time: "Bi-Weekly", cat: "house", numOfDays: 14)
        let task5 = RecomendedTask(name: "Laundry", time: "Bi-Weekly", cat: "house", numOfDays: 14)
        let task6 = RecomendedTask(name: "Go for a hike", time: "Bi-Weekly", cat: "health", numOfDays: 14)
        let task7 = RecomendedTask(name: "Tidy car up", time: "Bi-Weekly", cat: "car", numOfDays: 14)
        let task8 = RecomendedTask(name: "Organize closet", time: "Every 3 weeks", cat: "house", numOfDays: 21)
        let task9 = RecomendedTask(name: "Wash Sheets", time: "Every 3 weeks", cat: "house", numOfDays: 21)
        let task10 = RecomendedTask(name: "Meditate", time: "Every 3 weeks", cat: "health", numOfDays: 21)
        let task11 = RecomendedTask(name: "Clean bedroom", time: "Monthly", cat: "house", numOfDays: 30)
        let task12 = RecomendedTask(name: "Read a book", time: "Monthly", cat: "health", numOfDays: 30)
        let task13 = RecomendedTask(name: "Clean closet", time: "Bi-Monthly", cat: "house", numOfDays: 60)
        let task14 = RecomendedTask(name: "Dust", time: "Bi-Monthly", cat: "health", numOfDays: 60)
        let task15 = RecomendedTask(name: "Change toothbrush", time: "Bi-Monthly", cat: "hygeine", numOfDays: 60)
        let task16 = RecomendedTask(name: "Car wash", time: "Bi-Monthly", cat: "car", numOfDays: 60)
        let task17 = RecomendedTask(name: "Oil Change", time: "Every 3 months", cat: "car", numOfDays: 90)
        let task18 = RecomendedTask(name: "Clean Garage", time: "Every 4 months", cat: "house", numOfDays: 120)
        let task19 = RecomendedTask(name: "Emotional Health Day", time: "Every 4 months", cat: "health", numOfDays: 120)
        let task20 = RecomendedTask(name: "Deep clean house", time: "Every 6 months", cat: "house", numOfDays: 180)
        let task21 = RecomendedTask(name: "Teeth Cleaning", time: "Every 6 months", cat: "health", numOfDays: 180)
        let task22 = RecomendedTask(name: "Check up at Doctor", time: "Every 6 months", cat: "health", numOfDays: 180)
        let task23 = RecomendedTask(name: "Vacation!", time: "Anually", cat: "health", numOfDays: 365)
        let task24 = RecomendedTask(name: "New wiper", time: "Anually", cat: "car", numOfDays: 365)
        
        sampleTasks += [task1,task6,task10,task12,task14,task19,task21,task22,task23,task2,task3,task4,task5,task8,task9,task11,task13,task18,task20,task7,task16,task17,task24,task15]
    }

    func setUpNavBar() {
        self.tableView.backgroundColor = UIColor(red: 108, green: 122, blue: 137)
        self.navigationController?.toolbar.barTintColor = UIColor(red: 108, green: 122, blue: 137)
        navigationController!.navigationBar.barTintColor = UIColor(red: 108, green: 122, blue: 137)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleTasks.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
                checked[indexPath.row] = false
            } else {
                cell.accessoryType = .Checkmark
                checked[indexPath.row] = true
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RecomendedTaskTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecomendedTaskTableViewCell
        let recomendedTask = sampleTasks[indexPath.row]
        
        cell.nameLabel.text = recomendedTask.name
        cell.timeLabel.text = recomendedTask.time
        
        if(recomendedTask.cat == "health") {
            cell.iconImage.image = UIImage(named: "health")
            cell.backgroundColor = UIColor(red: 220, green: 98, blue: 111)
        }
        else if(recomendedTask.cat == "house") {
            cell.iconImage.image = UIImage(named: "house")
            cell.backgroundColor = UIColor(red: 236, green: 218, blue: 175)
        }
        else if(recomendedTask.cat == "hygeine") {
            cell.iconImage.image = UIImage(named: "hygeine")
            cell.backgroundColor = UIColor(red: 239, green: 150, blue: 136)
        }
        else if(recomendedTask.cat == "misc") {
            cell.iconImage.image = UIImage(named: "misc")
            cell.backgroundColor = UIColor(red: 235, green: 203, blue: 148)
        }else {
            cell.iconImage.image = UIImage(named: "car")
            cell.backgroundColor = UIColor(red: 107, green: 177, blue: 140)
        }
        
        if(!checked.isEmpty) {
            if !checked[indexPath.row] {
                cell.accessoryType = .None
            } else if checked[indexPath.row] {
                cell.accessoryType = .Checkmark
            }
        }

        return cell
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        for i in 0...checked.count-1 {
            if(checked[i] == true) {
                let calendar = NSCalendar.currentCalendar()
                let deadline = calendar.dateByAddingUnit(.Day, value: sampleTasks[i].numOfDays, toDate: deadlined, options: [])
                let task = Task(name: sampleTasks[i].name, deadline: deadline!, cat: sampleTasks[i].cat, days: sampleTasks[i].numOfDays, UUID: NSUUID().UUIDString)
                TaskList.sharedInstance.addTask(task)
            }
        }
        
        let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("ttvc") as! UITableViewController
        self.navigationController!.pushViewController(VC1, animated: true)
    }

}
