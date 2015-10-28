//
//  toDoPersist.swift
//  NJIT Student Guide
//
//  Created by Venkatesh Muthukrishnan on 10/27/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class toDoPersist {
    let titleNameSpace = ToDoAtrributes.items.rawValue
    class var sharedInstance: toDoPersist {
        
        struct Singleton {
            static let instance = toDoPersist()
        }
        
        return Singleton.instance
    }
    
    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    //insertion function into the persistent datastore
    func insertIntoDataStore(items: String!,tick: String!)->Bool{
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let record = NSEntityDescription.insertNewObjectForEntityForName("ToDoModel", inManagedObjectContext: context)
        record.setValue(items, forKey: "items")
        record.setValue(tick, forKey: "tick")
        
        do {
            try context.save()
            return true
        }catch {
            print("could not save")
            return false
        }
        
    }
    
    //fetch from the persistent datastore essentially CoreData
    func fetchFromDataStore() ->Array<ToDoModel> {
        var fetchedResults:Array<ToDoModel> = Array<ToDoModel>()
        do {
            let request = NSFetchRequest(entityName: "ToDoModel")
            
            let sortDescriptor = NSSortDescriptor(key: titleNameSpace,
                ascending: true)
            let sortDescriptors = [sortDescriptor]
            request.sortDescriptors = sortDescriptors
            let context: NSManagedObjectContext = appDel.managedObjectContext
            fetchedResults = try context.executeFetchRequest(request) as! [ToDoModel]
            
            
            
            
        } catch {
            print("there are no items")
        }
        return fetchedResults
    }

}
