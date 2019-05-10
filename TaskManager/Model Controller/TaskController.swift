//
//  TaskController.swift
//  TaskManager
//
//  Created by Dustin Koch on 5/8/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import CoreData


class TaskController {
    
    static let shared = TaskController()
    
    var fetchResultsController: NSFetchedResultsController<Task>
    
    init(){
        //build request off of our Entity
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        //build a sort descriptor for important peramiters
        let isCompleteDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        
        request.sortDescriptors = [isCompleteDescriptor]
        
        
        //initiialize a fetchedResultsController
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "Complete", cacheName: nil)
        
        //assign to the class property
        self.fetchResultsController = resultsController
        
        do{
            try fetchResultsController.performFetch()
        }catch{
            print("Error performing the fetch: \(error.localizedDescription)")
        }
    }
    
    //MARK: - CRUD Functions
    
    func createTask(name: String, due: Date, notes: String) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistence()

    }
    
    func changeBool(task: Task){
        task.isComplete = !task.isComplete
        saveToPersistence()
    }
    
    func deleteTask(task: Task) {
        let moc = CoreDataStack.context
        moc.delete(task)
        saveToPersistence()
    }

    
    func saveToPersistence() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch  {
            print("Error saving to persistence: \(error)")
        }
    
    }


    
}
