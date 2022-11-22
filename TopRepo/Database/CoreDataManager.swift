//
//  CoreDataManager.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 11.11.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    public static var shared: CoreDataManager = CoreDataManager()
    
    private init() {
        //Singleton class
    }
    
    //Defining PersistentContainer
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading CoreData persistent container failed \(error)")
            }
        }
        return container
    }()
    
    @discardableResult
    func addLastTrendingData(data: Data) -> TrendingEntity? {
        deleteAllData()
        
        let context = persistentContainer.viewContext
        let latestTrending = TrendingEntity(context: context)
        latestTrending.trendingData = data
        
        do {
            try context.save()
            return latestTrending
        } catch(let err){
            Log.error("error in saving context \(err.localizedDescription)")
        }
        return nil
    }
    
    func fetchLastTrendings() -> [TrendingEntity] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<TrendingEntity>(entityName: "TrendingEntity")
        guard let trending = try? context.fetch(request) else {
            return []
        }
        return trending
    }
    
    func deleteAllData() {
        let context = persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TrendingEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            Log.error("There was an error in Batch delete")
        }
    }
}
