//
//  Task.swift
//  ToDoList
//
//  Created by Nayeem on 12/7/15.
//  Copyright © 2015 Mohammed Khan. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    @NSManaged var tName: String?
    @NSManaged var tDesc: String?
    @NSManaged var tImage: NSData?
}
