//
//  CoreDataHelpers.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 20/11/2022.
//  Based upon work originally by Alexey Naumov.

import CoreData
import Combine

// MARK: - ManagedEntity

protocol ManagedEntity: NSFetchRequestResult { }

extension ManagedEntity where Self: NSManagedObject {
    
    static var entityName: String {
        let nameMO = String(describing: Self.self)
        let suffixIndex = nameMO.index(nameMO.endIndex, offsetBy: -2)
        return String(nameMO[..<suffixIndex])
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self? {
        return NSEntityDescription
            .insertNewObject(forEntityName: entityName, into: context) as? Self
    }
    
    static func delete(fetchRequest: NSFetchRequest<NSFetchRequestResult>, in context: NSManagedObjectContext) throws {
        // Setting includesPropertyValues to false means
        // the fetch request will only get the managed
        // object ID for each object
        fetchRequest.includesPropertyValues = false

        // Perform the fetch request
        let objects = try context.fetch(fetchRequest)
            
        // Delete the objects
        for object in objects {
            if let mo = object as? NSManagedObject {
                context.delete(mo)
            }
        }
    }
    
    static func newFetchRequest() -> NSFetchRequest<Self> {
        return .init(entityName: entityName)
    }
    
    static func newFetchRequestResult() -> NSFetchRequest<NSFetchRequestResult> {
        return .init(entityName: entityName)
    }
}

// MARK: - NSManagedObjectContext

extension NSManagedObjectContext {
    
    func configureAsReadOnlyContext() {
        automaticallyMergesChangesFromParent = true
        mergePolicy = NSRollbackMergePolicy
        undoManager = nil
        shouldDeleteInaccessibleFaults = true
    }
    
    func configureAsUpdateContext() {
        mergePolicy = NSOverwriteMergePolicy
        undoManager = nil
    }
}

// MARK: - Misc

extension NSSet {
    func toArray<T>(of type: T.Type) -> [T] {
        allObjects.compactMap { $0 as? T }
    }
}

extension NSOrderedSet {
    func toArray<T>(of type: T.Type) -> [T] {
        array.compactMap { $0 as? T }
    }
}
