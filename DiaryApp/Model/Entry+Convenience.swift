//
//  Entry+Convenience.swift
//  DiaryApp
//
//  Created by Michael Flowers on 1/28/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    
    @discardableResult
    convenience init(name: String, body: String?, longitude: Double, latitude: Double, timestamp: Date =  Date(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext){
        self.init(context: context)
        self.name = name
        self.body = body
        self.longitude = longitude
        self.latitude = latitude
        self.timestamp = timestamp
    }
}
