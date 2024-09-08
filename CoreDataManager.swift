//
//  CoreDataManager.swift
//  gratify
//
//  Created by Kevin Zhou on 4/21/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Gratify_App")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchDayEntries() -> [DayEntry] {
        let fetchRequest: NSFetchRequest<DayEntry> = DayEntry.fetchRequest()
        do {
            let dayEntries = try managedContext.fetch(fetchRequest)
            return dayEntries
        } catch {
            print("Failed to fetch day entries: \(error)")
            return []
        }
    }
}

