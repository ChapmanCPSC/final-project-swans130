//
//  TaskTableViewController.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/3/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController, TableViewCellDelegate, TableViewComplete {
    
    @IBOutlet var menuView: UIView!
    
    var selection : Int = 0
    var timeSelection : Int = 0
    let date = NSDate()
    var weeksRemaining : Int = 0
    var daysRemaining : Int = 0
    var hoursRemaining : Int = 0
    var minutesRemaining : Int = 0
    var secondsRemaining : Int = 0
    var tasks = [Task]()
    let items = ["All Tasks", "Today","Week View", "Month View"]

    @IBOutlet var circleB: UIBarButtonItem!
    @IBOutlet var hygeineB: UIBarButtonItem!
    @IBOutlet var carB: UIBarButtonItem!
    @IBOutlet var miscB: UIBarButtonItem!
    @IBOutlet var houseB: UIBarButtonItem!
    @IBOutlet var healthB: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpDrownDown()
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(TaskTableViewController.longPress(_:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        circleB.tintColor = UIColor.purpleColor()
        refreshList()
        setUpNavBar()
    }
    
    func refreshList() {
        tasks = TaskList.sharedInstance.allTasks()
        if (tasks.count >= 64) {
            self.navigationItem.rightBarButtonItem!.enabled = false // disable 'add' button
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
    
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let heightForRow = tableView.rowHeight
        let task = tasks[indexPath.row]
        if(selection == 1 && task.cat != "house") {
            return 0
        }
        else if(selection == 2 && task.cat != "car") {
            return 0
        }
        else if(selection == 3 && task.cat != "hygeine") {
            return 0
        }
        else if(selection == 4 && task.cat != "health") {
            return 0
        }
        else if(selection == 5 && task.cat != "misc") {
            return 0
        }
        else if(timeSelection == 1 && task.deadline.daysFrom(date) != 0) {
            return 0
        }
        else if(timeSelection == 2 && task.deadline.daysFrom(date) > 7) {
            return 0
        }
        else if(timeSelection == 3 && task.deadline.daysFrom(date) > 30) {
            return 0
        }
        else if(timeSelection == 0) {
            return heightForRow
        }
        else {
            return heightForRow
        }
    }
    
    func taskDeleted(task: Task) {
        let index = (tasks as NSArray).indexOfObject(task)
        if index == NSNotFound { return }
        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        tasks.removeAtIndex(index)
        // use the UITableView to animate the removal of this row
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        TaskList.sharedInstance.removeItem(task) // delete backing property list entry and unschedule local notification (if it still exists)
        self.navigationItem.rightBarButtonItem!.enabled = true // we definitely have under 64 notifications scheduled now, make sure 'add' button is enabled
        tableView.endUpdates()    
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TaskTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        weeksRemaining = task.deadline.weeksFrom(date)
        daysRemaining = task.deadline.daysFrom(date)
        hoursRemaining = task.deadline.hoursFrom(date)
        minutesRemaining = task.deadline.minutesFrom(date)
        secondsRemaining = task.deadline.secondsFrom(date)
        cell.nameLabel.text = task.name
        let dateFormatterOne = NSDateFormatter()
        dateFormatterOne.dateFormat = "E, MMM dd"
        let due = dateFormatterOne.stringFromDate(task.deadline)
        let dateFormatterTwo = NSDateFormatter()
        dateFormatterTwo.dateFormat = "h:m a"
        if(daysRemaining == 1) {
            cell.timeLabel.text = ("\(daysRemaining) day - \(due)")
        }
        else if(daysRemaining != 0) {
             cell.timeLabel.text = ("\(daysRemaining) days - \(due) ")
        }
        else if(daysRemaining <= 0 && hoursRemaining <= 0 && minutesRemaining <= 0 && secondsRemaining <= 0) {
            cell.timeLabel.text = ("Overdue - \(due)")
        } else {
            cell.timeLabel.text = ("Today - \(due)")
        }
        
                switch (task.cat) {
                case "house":
                    cell.iconImage.image = UIImage(named: "house")
                    cell.backgroundColor = UIColor(red: 236, green: 218, blue: 175)
                case "health":
                    cell.iconImage.image = UIImage(named: "health")
                    cell.backgroundColor = UIColor(red: 220, green: 98, blue: 111)
                case "hygeine":
                    cell.iconImage.image = UIImage(named: "hygeine")
                    cell.backgroundColor = UIColor(red: 239, green: 150, blue: 136)
                case "car":
                    cell.iconImage.image = UIImage(named: "car")
                    cell.backgroundColor = UIColor(red: 107, green: 177, blue: 140)
                case "misc":
                    cell.iconImage.image = UIImage(named: "misc")
                    cell.backgroundColor = UIColor(red: 235, green: 203, blue: 148)
                default:
                    cell.iconImage.image = UIImage(named: "misc")
                    cell.backgroundColor = UIColor(red: 235, green: 203, blue: 148)
                }
        
        if(self.selection == 0) {
            if(task.cat != "blah") {
                cell.hidden = false
                
            }
        }
        if(self.selection == 1) {
            
            if(task.cat != "house") {
                cell.hidden = true
            }
        }
        if(self.selection == 2) {
            if(task.cat != "car") {
                cell.hidden = true
            }
        }
        if(self.selection == 3) {
            
            if(task.cat != "hygeine") {
                cell.hidden = true
            }
        }
        if(self.selection == 4) {
            if(task.cat != "health") {
                cell.hidden = true
            }
        }
        if(self.selection == 5) {
            if(task.cat != "misc") {
                cell.hidden = true
            }
        }
        
        cell.delegate = self
        cell.task = task
        cell.delegateComplete = self

        return cell

    }
    
    func reloadData() {
        self.tableView.reloadData()
        let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("nvc")
        self.navigationController!.pushViewController(VC1, animated: true)
        print("being called")
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            let touchPoint = longPressGestureRecognizer.locationInView(self.view)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                let task = tasks[indexPath.row]
                taskDeleted(task)
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("utvc") as! UpdateTaskViewController
                self.presentViewController(vc, animated: true, completion: nil)
                
            }
        }
    }
    
    func setUpNavBar() {
        self.tableView.backgroundColor = UIColor(red: 108, green: 122, blue: 137)
        self.navigationController?.toolbar.barTintColor = UIColor(red: 108, green: 122, blue: 137)
        navigationController!.navigationBar.barTintColor = UIColor(red: 108, green: 122, blue: 137)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    func setUpDrownDown() {
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        self.navigationItem.titleView = menuView
        menuView.cellTextLabelFont = UIFont(name: "Futura Medium", size: 12)
        menuView.cellBackgroundColor = UIColor(red: 108, green: 122, blue: 137)
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            if(indexPath == 0) {
                self.timeSelection = 0
                self.tableView.reloadData()
            }
            if(indexPath == 1) {
                self.timeSelection = 1
                self.tableView.reloadData()
            }
            if(indexPath == 2) {
                self.timeSelection = 2
                self.tableView.reloadData()
            }
            if(indexPath == 3) {
                self.timeSelection = 3
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func circleButton(sender: UIBarButtonItem) {
        selection = 0
        changeButtonColor()
        tableView.reloadData()
    }
    
    @IBAction func houseButton(sender: AnyObject) {
        selection = 1
        changeButtonColor()
        tableView.reloadData()
    }
    
    
    @IBAction func carButton(sender: AnyObject) {
        selection = 2
        changeButtonColor()
        tableView.reloadData()
    }
    
    
    @IBAction func hygeineButton(sender: AnyObject) {
        selection = 3
        changeButtonColor()
        tableView.reloadData()
    }
    
    
    @IBAction func healthButton(sender: AnyObject) {
        selection = 4
        changeButtonColor()
        tableView.reloadData()
    }
    
    
    @IBAction func miscButton(sender: AnyObject) {
        selection = 5
        changeButtonColor()
        tableView.reloadData()
    }

    func changeButtonColor() {
        if (selection == 1) {
            houseB.tintColor = UIColor(red: 236, green: 218, blue: 175)
            carB.tintColor = UIColor.whiteColor()
            hygeineB.tintColor = UIColor.whiteColor()
            healthB.tintColor = UIColor.whiteColor()
            miscB.tintColor = UIColor.whiteColor()
            circleB.tintColor = UIColor.whiteColor()
        }
        else if (selection == 2) {
            carB.tintColor = UIColor(red: 107, green: 177, blue: 140)
            houseB.tintColor = UIColor.whiteColor()
            hygeineB.tintColor = UIColor.whiteColor()
            healthB.tintColor = UIColor.whiteColor()
            miscB.tintColor = UIColor.whiteColor()
            circleB.tintColor = UIColor.whiteColor()
        }
        else if (selection == 3) {
            hygeineB.tintColor = UIColor(red: 239, green: 150, blue: 136)
            houseB.tintColor = UIColor.whiteColor()
            carB.tintColor = UIColor.whiteColor()
            healthB.tintColor = UIColor.whiteColor()
            miscB.tintColor = UIColor.whiteColor()
            circleB.tintColor = UIColor.whiteColor()
        }
        else if (selection == 4) {
            healthB.tintColor = UIColor(red: 220, green: 98, blue: 111)
            houseB.tintColor = UIColor.whiteColor()
            carB.tintColor = UIColor.whiteColor()
            hygeineB.tintColor = UIColor.whiteColor()
            miscB.tintColor = UIColor.whiteColor()
            circleB.tintColor = UIColor.whiteColor()
        }
        else if (selection == 5) {
            miscB.tintColor = UIColor(red: 235, green: 203, blue: 148)
            houseB.tintColor = UIColor.whiteColor()
            carB.tintColor = UIColor.whiteColor()
            hygeineB.tintColor = UIColor.whiteColor()
            healthB.tintColor = UIColor.whiteColor()
            circleB.tintColor = UIColor.whiteColor()
        }
        else {
            circleB.tintColor = UIColor.purpleColor()
            houseB.tintColor = UIColor.whiteColor()
            carB.tintColor = UIColor.whiteColor()
            hygeineB.tintColor = UIColor.whiteColor()
            healthB.tintColor = UIColor.whiteColor()
            miscB.tintColor = UIColor.whiteColor()
            
        }
    }

}
