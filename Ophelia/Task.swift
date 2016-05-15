//
//  Task.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/3/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

class Task {
    
    var name: String
    var deadline: NSDate
    var cat: String
    var days: Int
    var UUID: String
    
    init (name:String, deadline:NSDate, cat: String, days: Int, UUID: String){
        self.name = name;
        self.deadline = deadline;
        self.cat = cat
        self.days = days
        self.UUID = UUID
    }
}
