//
//  FileForCoreDataWorksWith.swift
//  coreDataTrain
//
//  Created by Andrey Minin on 20/03/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
import CoreData

typealias SaveComplition = (Error?) -> ()

class CoreDataStack {
    var storeURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsURL.appendingPathComponent("mystor.sqlite")
    }
    
    /*init() {
        dataModelName = "coreDataModel"
        dataModelExtension = "momd"
        //saveContext = masterContext
    }*/
    
    var dataModelName = "coreDataModel"
    
    var dataModelExtension = "momd"
    
    //let saveContext: NSManagedObjectContext
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modeUrl = Bundle.main.url(forResource: self.dataModelName, withExtension: self.dataModelExtension)!
        
        return NSManagedObjectModel(contentsOf: modeUrl)!
    }()
    
    
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeURL, options: nil)
        } catch {
            assert(false, "Error adding store: \(error)")
        }
        
        return coordinator
    }()
    
    lazy var masterContext: NSManagedObjectContext = {
        var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        masterContext.mergePolicy = NSOverwriteMergePolicy
        
        return masterContext
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        mainContext.parent = self.masterContext
        mainContext.mergePolicy = NSOverwriteMergePolicy
        
        return mainContext
    }()
    
    lazy var saveContext: NSManagedObjectContext = {
        var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        saveContext.parent = self.mainContext
        saveContext.mergePolicy = NSOverwriteMergePolicy
        
        return saveContext
    }()
    
    func performSave(with context: NSManagedObjectContext, completion: @escaping ((Error?)->())) {
        guard context.hasChanges else {
            completion(nil)
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch {
                print("Context save error \(error)")
            }
            
            if let parentContext = context.parent {
                self.performSave(with: parentContext, completion: completion)
            } else {
                completion(nil)
            }
        }
    }
}


extension AppUser {
    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser else { return nil }
        
        appUser.name = "kekekekekekekeekkekekekekekeke"
        
        return appUser
    }
    
    
    
    static func findOrInsertAppUser(in context : NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("model is not available in context")
            assert(false)
            return nil
        }
        
        var appUser: AppUser?
        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else {
            return nil
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple AppUsers Found!")
            if let foundUser = results.first {
                appUser = foundUser
            }
        } catch {
            print("failde to catch AppUser \(error)")
        }
        
        if appUser == nil {
            appUser = AppUser.insertAppUser(in: context)
        }
        
        return appUser
    }
    
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
        let templateName = "AppUser"
        
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
            assert(false, "No template with name \(templateName)")
            return nil
        }
        
        return fetchRequest
    }
}

extension User {
    func insertUser(in: NSManagedObjectContext) {}
}

