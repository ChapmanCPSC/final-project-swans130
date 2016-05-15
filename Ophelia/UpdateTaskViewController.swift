//
//  UpdateTaskViewController.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/8/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

class UpdateTaskViewController: UIViewController {

    @IBOutlet var titleText: UITextField!
    @IBOutlet var categorySegment: UISegmentedControl!
    @IBOutlet var deadlineDate: UIDatePicker!
    
    var name : String = ""
    var categ : String = ""
    var repeatDay : Int = 0
    
    
    override func viewDidLoad() {
        print("name \(name) cat \(categ) repeat \(repeatDay)")
        super.viewDidLoad()
        deadlineDate.minimumDate = NSDate()
        deadlineDate.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        titleText.layer.borderWidth = 1
        titleText.layer.cornerRadius = 8
        titleText.layer.borderColor = UIColor.whiteColor().CGColor
        titleText.attributedPlaceholder = NSAttributedString(string:"Enter New Title",
                                                             attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        daysTextField.layer.borderWidth = 1
        daysTextField.layer.cornerRadius = 8
        daysTextField.layer.borderColor = UIColor.whiteColor().CGColor
        daysTextField.attributedPlaceholder = NSAttributedString(string:"#Days to Repeat ex. 7 (weekly)",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        //taskDatePicker.datePickerMode = UIDatePickerMode.Date
        deadlineDate.minuteInterval = 10
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var cat : String = "house";
    @IBAction func categoryChanged(sender: AnyObject) {
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
    var repeatInterval = 0
    @IBOutlet var daysTextField: UITextField!
    
    func fixNotificationDate(dateToFix: NSDate) -> NSDate {
        let dateComponets: NSDateComponents = NSCalendar.currentCalendar().components([.Day, .Month, .Year, .Hour,.Minute], fromDate: dateToFix)
        
        dateComponets.second = 0
        
        let fixedDate: NSDate! = NSCalendar.currentCalendar().dateFromComponents(dateComponets)
        
        return fixedDate
    }
    
    @IBAction func updateButton(sender: AnyObject) {
        if let mInt = Int(daysTextField.text!) {
            let taskItem = Task(name: titleText.text!, deadline: fixNotificationDate(deadlineDate.date), cat: cat, days: mInt, UUID: NSUUID().UUIDString)
            TaskList.sharedInstance.addTask(taskItem) // schedule a local notification to persist this item
        } else {
            let taskItem = Task(name: titleText.text!, deadline: fixNotificationDate(deadlineDate.date), cat: cat, days: repeatInterval, UUID: NSUUID().UUIDString)
            TaskList.sharedInstance.addTask(taskItem) // schedule a local notification to persist this item
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
