//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Dima Gorbachev on 02.09.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import CoreData
import UIKit
import StorageService

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    private let fetchRequest: NSFetchRequest<PostEntity>
    private lazy var context = persistentContainer.viewContext
    
    private lazy var saveContext: NSManagedObjectContext = {
        let saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
    private init() {
        let container = NSPersistentContainer(name: "CoreDataPost")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        self.persistentContainer = container
        self.fetchRequest = PostEntity.fetchRequest()
    }
    
    func saveFavourite (post: PostData) {
        saveContext.perform {
            let favouritePost = PostEntity(context: self.saveContext)
            favouritePost.author = post.author
            favouritePost.content = post.description
            favouritePost.likesCount = Int16(post.likes)
            favouritePost.viewsCount = Int16(post.views)
            favouritePost.image =  post.image
            
            do {
                try self.saveContext.save()
                print("Post is saved")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
