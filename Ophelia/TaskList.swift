//
//  TaskList.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/5/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import Foundation
import UIKit

class TaskList {
    class var sharedInstance : TaskList {
        struct Static {
        static let instance : TaskList = TaskList()
        }
        return Static.instance
    }
    
    private let ITEMS_KEY = "taskItems"
    
    func addTask(task: Task) {
        var taskDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary()
        taskDictionary[task.UUID] = ["deadline": task.deadline, "title": task.name, "cat": task.cat, "days": task.days, "UUID": task.UUID]
        NSUserDefaults.standardUserDefaults().setObject(taskDictionary, forKey: ITEMS_KEY)
        
        
        let notification = UILocalNotification()
        notification.category = "TODO_CATEGORY"
        notification.alertBody = "Have you \"\(task.name)\" yet?" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = task.deadline // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": task.UUID, ] // assign a unique identifier to the notification so that we can retrieve it later
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    func updateTask(task: Task) {
        
    }
    
    
    func allTasks() -> [Task] {
        let taskDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let tasks = Array(taskDictionary.values)
        return tasks.map({Task(name: $0["title"] as! String, deadline: $0["deadline"] as! NSDate, cat: $0["cat"] as! String, days: $0["days"] as! Int, UUID: $0["UUID"] as! String!)}).sort({(left: Task, right:Task) -> Bool in
            (left.deadline.compare(right.deadline) == .OrderedAscending) })
    }
    
    func removeItem(item: Task) {
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! as [UILocalNotification] { // loop through notifications...
            if (notification.userInfo!["UUID"] as! String == item.UUID) { // ...and cancel the notification that corresponds to this TodoItem instance (matched by UUID)
                UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                break
            }
        }
        if var tasks = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) {
            tasks.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(tasks, forKey: ITEMS_KEY) // save/overwrite todo item list
        }
    }
    
    func scheduleReminderforItem(item: Task) {
        let notification = UILocalNotification() // create a new reminder notification
        notification.alertBody = "Reminder: Task \"\(item.name)\" is Due" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = NSDate().add(2) // 60 minutes from current time NOT WORKING
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": item.name, "UUID": item.UUID] // assign a unique identifier to the notification that we can use to retrieve it later
        notification.category = "TODO_CATEGORY"
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

}

