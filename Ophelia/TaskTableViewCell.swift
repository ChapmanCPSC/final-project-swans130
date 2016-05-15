//
//  TaskTableViewCell.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/3/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import UIKit

// A protocol that the TableViewCell uses to inform its delegate of state change
protocol TableViewCellDelegate {
    func taskDeleted(task: Task)
}

protocol TableViewComplete {
    func reloadData()
}

class TaskTableViewCell: UITableViewCell {
    
    var delegateComplete: TableViewComplete?
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false, completeOnDragRelease = false
    var delegate: TableViewCellDelegate?
    var task: Task?

    @IBOutlet var iconImage: UIImageView!

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(TaskTableViewCell.handlePan(_:)))
        recognizer.delegate = self
        addGestureRecognizer(recognizer)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - horizontal pan gesture methods
    func handlePan(recognizer: UIPanGestureRecognizer) {
        // 1
        if recognizer.state == .Began {
            // when the gesture begins, record the current center location
            originalCenter = center
        }
        // 2
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            // has the user dragged the item far enough to initiate a delete/complete?
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
            
            completeOnDragRelease = frame.origin.x > frame.size.width / 2.0
        }
        // 3
        if recognizer.state == .Ended {
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                                       width: bounds.size.width, height: bounds.size.height)
            if deleteOnDragRelease {
                if delegate != nil && task != nil {
                    // notify the delegate that this item should be deleted
                    delegate!.taskDeleted(task!)
                }
            } else if completeOnDragRelease {
                if task != nil {
                    let calendar = NSCalendar.currentCalendar()
                    let deadline = calendar.dateByAddingUnit(.Day, value: task!.days, toDate: NSDate(), options: [])
                    let newTask = Task(name: task!.name, deadline: deadline!, cat: task!.cat, days: task!.days, UUID: NSUUID().UUIDString)
                    delegate!.taskDeleted(task!)
                    TaskList.sharedInstance.addTask(newTask)
                    print("Complete task called from cell")
                    self.delegateComplete?.reloadData()
                }

                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            } else {
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            }
        }
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }

}


