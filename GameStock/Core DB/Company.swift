//
//  Company.swift
//  GameStock
//
//  Created by CS3714 on 4/21/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation
import CoreData

/*
 🔴 Set Current Product Module:
    In xcdatamodeld editor, select Trip, show Data Model Inspector, and
    select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
    In xcdatamodeld editor, select Trip, show Data Model Inspector, and
    select Manual/None from Codegen menu.
*/
 
// ❎ CoreData Company entity public class
public class Company: NSManagedObject, Identifiable {
    @NSManaged public var name: String?
    @NSManaged public var hqLatitude: NSNumber?
    @NSManaged public var hqLongitude: NSNumber?
    @NSManaged public var stock: Stock?
    @NSManaged public var photo: Photo?
}
 
