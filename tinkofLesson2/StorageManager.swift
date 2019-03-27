//
//  StorageManager.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 27/03/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StorageManager: NSObject {
    
    // Init core data stack:
    let coreDataStack = CoreDataStack()
    
    // Save function:
    func saveProfile(profile: UserProfile, completion: @escaping (Error?) -> Void) {
        let appUser = AppUser.findOrInsertAppUser(in: coreDataStack.saveContext)
        
        self.coreDataStack.saveContext.perform {
            appUser?.name = profile.name
            appUser?.descr = profile.description
            appUser?.image = profile.profileImage.jpegData(compressionQuality: 1.0)
            
            // For Multipeer:
            UserDefaults.standard.set(profile.name, forKey: "profileName")
            
            self.coreDataStack.performSave(with: self.coreDataStack.saveContext) { (error) in
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    // Load function:
    func readProfile(completion: @escaping (UserProfile) -> ()) {
        let appUser = AppUser.findOrInsertAppUser(in: coreDataStack.mainContext)
        let profile: UserProfile
        let name = appUser?.name ?? "Пользователь \(UIDevice.current.name)"
        let description = appUser?.descr ?? "Если вы видите этот текст, значит девайс был запущен впервые."
        let image: UIImage
        
        //Image handling:
        if let imageData = appUser?.image {
            image = UIImage(data: imageData) ?? UIImage(named: "placeholder-user")!
        } else {
            image = UIImage(named: "placeholder-user")!
        }
        
        profile = UserProfile(name: name, descr: description, profImag: image)
        DispatchQueue.main.async {
            completion(profile)
        }
    }
}
