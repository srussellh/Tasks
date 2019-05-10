//
//  TaskTableViewCell.swift
//  TaskManager
//
//  Created by Dustin Koch on 5/8/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit
//1
protocol TaskTableViewCellDelegate: class {
    func toggleSettingForCell(cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    @IBOutlet weak var taskCompleteSquare: UIButton!
    
    //2
    weak var delegate: TaskTableViewCellDelegate?
    
    @IBAction func completeTaskButtonTapped(_ sender: UIButton) {
        //3
        delegate?.toggleSettingForCell(cell: self)
        
    }
    
    func updateButton(_ isComplete: Bool) {
        //use the isCOmplete to determine which image to display
        let imageName = isComplete ? "checked" : "unchecked"
        //set the image to the button
        taskCompleteSquare.setImage(UIImage(named: imageName), for: .normal)
    }
}
extension TaskTableViewCell{
    //receive orders from the tableView
    func update(withTask task: Task) {
        updateButton(task.isComplete)
        taskNameLabel.text = task.name
        taskDueDateLabel.text = task.due?.stringValue()
        
    }
}
