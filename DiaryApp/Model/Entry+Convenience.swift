//
//  Entry+Convenience.swift
//  DiaryApp
//
//  Created by Michael Flowers on 1/28/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import Foundation
import CoreData

enum EntryMood: String {
    case happy = "😃"
    case chillin = "😐"
    case sad = "😟"
    
    static var allMoods: [EntryMood] {
        return [.happy, .chillin, .sad]
    }
}

extension Entry {
    
    @discardableResult
    convenience init(name: String, mood: EntryMood, body: String?, longitude: Double, latitude: Double, timestamp: Date =  Date(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext){
        self.init(context: context)
        self.name = name
        self.mood = mood.rawValue
        self.body = body
        self.longitude = longitude
        self.latitude = latitude
        self.timestamp = timestamp
    }
}
