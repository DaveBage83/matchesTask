//
//  CoreDataStack.swift
//  Matches Fashion Test App
//  Created by David Bage on 20/11/2022.
//  Based upon work originally by Alexey Naumov.

import CoreData

class CoreDataContextProvider {
    // Current view context
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var persistentContainer: NSPersistentContainer
    
    init(completionClosure: ((Error?) -> Void)? = nil) {
        // Persistent container creation
        persistentContainer = NSPersistentContainer(name: "MatchesTestDataModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Unable to load core data stack: \(error)")
            }
            completionClosure?(error)
        }
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
}
