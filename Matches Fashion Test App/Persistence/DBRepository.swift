//
//  DBRepository.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 21/11/2022.
//

import CoreData

// Enum to describe core data errors
enum CoreDataError: Error {
    case invalidManagedObjectType
}

protocol DBRepository {
    associatedtype Entity
    
    // Get an array of entities
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error>
    
    // Create entity
    func create() -> Result<Entity, Error>
    
    // Delete entity
    func delete(entities: [Entity]) -> Result<Bool, Error>
}

class CoreDataRepository<T: NSManagedObject>: DBRepository {
    typealias Entity = T
    
    let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    // Fetch array of entitites
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[T], Error> {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                return .success(fetchResults)
            } else {
                return .failure(CoreDataError.invalidManagedObjectType)
            }
        } catch {
            return .failure(error)
        }
    }
    
    // Create a new entity
    func create() -> Result<T, Error> {
        let className = String(describing: Entity.self).dropLast(2)
        
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: String(className), into: managedObjectContext) as? Entity else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving context")
        }
        
        return .success(managedObject)
    }
    
    // Delete an entity
    func delete(entities: [T]) -> Result<Bool, Error> {
        for entity in entities {
            managedObjectContext.delete(entity)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to delete")
        }
        
        return .success(true)
    }
}
