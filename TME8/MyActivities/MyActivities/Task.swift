//
//  Task.swift
//  MyActivities
//
//  Created by Max Corp on 11/28/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

import Foundation
import UIKit

class Task : NSObject{
    var taskTitle : String = ""
    var priorityLabel : String = ""
    var priority = Int()
    var image : UIImage?
    
    override init() {
        taskTitle = "New task"
        priorityLabel = "Current priority level: "
        priority = 0
        image = nil
    }
    
    init(title: String, prio: Int) {
        taskTitle = title
        priority = prio
    }
}
