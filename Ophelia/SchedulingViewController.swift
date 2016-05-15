//
//  ViewController.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/3/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

class SchedulingViewController : UIViewController {

    @IBOutlet var categorySegment: UISegmentedControl!
    @IBOutlet var titleText: UITextField!
    @IBOutlet var taskDatePicker: UIDatePicker!
    @IBOutlet var repeatSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDatePicker.minimumDate = NSDate()
        taskDatePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        //taskDatePicker.datePickerMode = UIDatePickerMode.Date
        taskDatePicker.minuteInterval = 1
        self.hideKeyboardWhenTappedAround()
        titleText.layer.borderWidth = 1
        titleText.layer.borderColor = UIColor.whiteColor().CGColor
        titleText.layer.cornerRadius = 8
        titleText.attributedPlaceholder = NSAttributedString(string:"Enter Title Here",
                                                               attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        repeatTextField.layer.borderWidth = 1
        repeatTextField.layer.borderColor = UIColor.whiteColor().CGColor
        repeatTextField.layer.cornerRadius = 8
        repeatTextField.attributedPlaceholder = NSAttributedString(string:"#Days to Repeat ex. 7 (weekly)",
                                                               attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationController!.navigationBar.barTintColor = UIColor(red: 108, green: 122, blue: 137)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    var cat : String = "house";

    @IBAction func categoryIndexChanged(sender: AnyObject) {
        switch categorySegment.selectedSegmentIndex
        {
        case 0:
            cat = "house"
        case 1:
            cat = "health"
        case 2:
            cat = "hygeine"
        case 3:
            cat = "car"
        case 4:
            cat = "misc"
        default:
            break; 
        }
    }
    
    
    @IBOutlet var repeatTextField: UITextField!
    var repeatInterval = 0

    func fixNotificationDate(dateToFix: NSDate) -> NSDate {
        let dateComponets: NSDateComponents = NSCalendar.currentCalendar().components([.Day, .Month, .Year, .Hour,.Minute], fromDate: dateToFix)
        
        dateComponets.second = 0
        
        let fixedDate: NSDate! = NSCalendar.currentCalendar().dateFromComponents(dateComponets)
        
        return fixedDate
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        if let mInt = Int(repeatTextField.text!) {
            let taskItem = Task(name: titleText.text!, deadline: fixNotificationDate(taskDatePicker.date), cat: cat, days: mInt, UUID: NSUUID().UUIDString)
            TaskList.sharedInstance.addTask(taskItem) // schedule a local notification to persist this item
//            let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("ttvc") as! UITableViewController
//            self.navigationController!.pushViewController(VC1, animated: true)
        } else {
            let taskItem = Task(name: titleText.text!, deadline: fixNotificationDate(taskDatePicker.date), cat: cat, days: repeatInterval, UUID: NSUUID().UUIDString)
            TaskList.sharedInstance.addTask(taskItem) // schedule a local notification to persist this item
//            let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("ttvc") as! UITableViewController
//            self.navigationController!.pushViewController(VC1, animated: true)

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }


}

