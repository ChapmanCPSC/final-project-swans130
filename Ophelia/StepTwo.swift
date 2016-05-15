//
//  StepTwp.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/7/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

class StepTwo: UIViewController {
    let prefs = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var timePicker: UIDatePicker!
    let date = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.minimumDate = NSDate()
        timePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        //taskDatePicker.datePickerMode = UIDatePickerMode.Date
        timePicker.minuteInterval = 10
    
    }
    
    @IBAction func readyButton(sender: AnyObject) {
        let formatterHour: NSDateFormatter = NSDateFormatter()
        formatterHour.dateFormat = "yyyy MM dd HH mm a"
        let dateString = formatterHour.stringFromDate(timePicker.date)
        prefs.setValue(dateString, forKey: "dateString")
        let hour = prefs.stringForKey("hourString")
        print("hour: \(hour)")
        
        print("blah \(fixDate(timePicker.date))")
        let formatterMinute: NSDateFormatter = NSDateFormatter()
        formatterMinute.dateFormat = "mm"
        let minuteString = formatterMinute.stringFromDate(timePicker.date)
        prefs.setValue(minuteString, forKey: "minuteString")
        let minute = prefs.stringForKey("minuteString")
        print("minute: \(minute)")
        
        let formatterA: NSDateFormatter = NSDateFormatter()
        formatterA.dateFormat = "a"
        let aString = formatterA.stringFromDate(timePicker.date)
        prefs.setValue(aString, forKey: "aString")
        let a = prefs.stringForKey("aString")
        print("a: \(a)")
        
        
    }
    
    func fixDate(dateToFix: NSDate) -> NSDate {
        let dateComponets: NSDateComponents = NSCalendar.currentCalendar().components([.Day, .Month, .Year], fromDate: dateToFix)
        dateComponets.hour = 5
        dateComponets.minute = 30
        dateComponets.second = 0
        
        let fixedDate: NSDate! = NSCalendar.currentCalendar().dateFromComponents(dateComponets)
        
        return fixedDate
    }
    
}


