//
//  Persistant.swift
//  BookMyCourt
//
//  Created by Vallamsetty,Revanth on 4/22/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import CoreData

class DataController: NSObject {
    var managedObjectContext: NSManagedObjectContext
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
}
