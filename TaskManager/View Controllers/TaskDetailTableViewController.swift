//
//  TaskDetailTableViewController.swift
//  TaskManager
//
//  Created by Dustin Koch on 5/8/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailTableViewController: UITableViewController {
    
    //Mark: - Landing pad for segue
    var task: Task?

    //Mark: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDetailTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet weak var taskDueTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDueTextField.inputView = dueDatePicker
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let task = task {
            guard let taskName = taskNameTextField.text,
                taskNameTextField.text != "" else { return }
            guard let taskDetail = taskDetailTextView.text,
                taskDetailTextView.text != "" else { return }
            guard let date = taskDueTextField.text,
                taskDueTextField.text != "" else { return }
            task.due = dueDatePicker.date
            task.name = taskNameTextField.text
            task.notes = taskDetailTextView.text
            TaskController.shared.saveToPersistence()
            self.navigationController?.popViewController(animated: true)
        } else {
            guard let taskName = taskNameTextField.text,
                taskNameTextField.text != "" else { return }
            guard let taskDetail = taskDetailTextView.text,
                taskDetailTextView.text != "" else { return }
            guard let date = taskDueTextField.text,
                taskDueTextField.text != "" else { return }
            TaskController.shared.createTask(name: taskName, due: dueDatePicker.date, notes: taskDetail)
            TaskController.shared.saveToPersistence()
            self.navigationController?.popViewController(animated: true)
        }

    }
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let dueDateValue = dueDatePicker.date
        taskDueTextField.text = dueDateValue.stringValue()
    }
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    

    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskDetailTextView.text = task.notes
        taskDueTextField.text = task.due?.stringValue()
    }
}
