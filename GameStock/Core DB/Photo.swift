//
//  Photo.swift
//  GameStock
//
//  Created by CS3714 on 4/21/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation
import CoreData
// ❎ CoreData Photo entity public class
public class Photo: NSManagedObject, Identifiable {
    @NSManaged public var imageUrl: String?
    @NSManaged public var company: Company?
}
