//
//  Task+Convenience.swift
//  TaskManager
//
//  Created by Dustin Koch on 5/8/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String, due: Date, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
    }
    
}//end of extension
