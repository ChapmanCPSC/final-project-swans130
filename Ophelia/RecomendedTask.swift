//
//  RecomendedTask.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/7/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

class RecomendedTask: NSObject {

    var name: String
    var time: String
    var cat: String
    var numOfDays : Int
    
    init (name:String, time:String, cat: String, numOfDays: Int) {
        self.name = name;
        self.time = time;
        self.cat = cat
        self.numOfDays = numOfDays
    }
    
}
