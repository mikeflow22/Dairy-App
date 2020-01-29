//
//  EntryController.swift
//  DiaryApp
//
//  Created by Michael Flowers on 1/28/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let shared = EntryController()
    var fetchedResultsController: NSFetchedResultsController<Entry>
    
    init(){
        let fetchRequst: NSFetchRequest<Entry> =  Entry.fetchRequest()
        fetchRequst.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequst, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch  {
            print("Error in: \(#function)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)")
        }
    }
    
    //MARK: - CRUD Methods
    func createEntryWith(name: String, mood: EntryMood, body: String, longitude: Double, latitude: Double){
        Entry(name: name, mood: mood, body: body, longitude: longitude, latitude: latitude)
        saveToPersistentStore()
        
    }
    
    func delete(entry: Entry){
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStore()
    }
    
    func update(entry: Entry, withNewName name: String, withNewMood mood: EntryMood, withNewBody body: String, withNewLongitude longitude: Double, withNewLatitude latitude: Double, withNewTimestamp timestamp: Date = Date()){
        entry.name = name
        entry.body = body
        entry.mood = mood.rawValue
        entry.longitude = longitude
        entry.latitude = latitude
        entry.timestamp = timestamp
        saveToPersistentStore()
    }
    
    func saveToPersistentStore(){
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch  {
            print("Error in: \(#function)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
