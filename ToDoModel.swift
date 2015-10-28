//
//  ToDoModel.swift
//  NJIT Student Guide
//
//  Created by Venkatesh Muthukrishnan on 10/27/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import Foundation
import CoreData
enum ToDoAtrributes: String {
    case
    items = "items",
    tick =  "tick"
    
    static let getAll = [items,tick]
}
@objc(ToDoModel)
class ToDoModel: NSManagedObject {
    @NSManaged var items: String?
    @NSManaged var tick: String?

// Insert code here to add functionality to your managed object subclass

}
