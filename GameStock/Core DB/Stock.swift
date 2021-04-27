//
//  Stock.swift
//  GameStock
//
//  Created by CS3714 on 4/21/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation
import CoreData
 
// ❎ CoreData Stock entity public class
public class Stock: NSManagedObject, Identifiable {
 
    @NSManaged public var percentChange: NSNumber?
    @NSManaged public var high: NSNumber?
    @NSManaged public var low: NSNumber?
    @NSManaged public var isMarketOpen: NSNumber?
    @NSManaged public var label: String?
    @NSManaged public var latestPrice: NSNumber?
    @NSManaged public var primaryExchange: String?
    @NSManaged public var symbol: String?
    @NSManaged public var company: Company?
    @NSManaged public var numberPurchased: NSNumber?
}
 
extension Stock {
    /*
     ❎ CoreData @FetchRequest in TripList.swift invokes this Trip class method
        to fetch all of the Trip entities from the database.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Trip.allTripsFetchRequest() in any .swift file in your project.
     */
    static func favoritesRequest() -> NSFetchRequest<Stock> {
       
        let request: NSFetchRequest<Stock> = Stock.fetchRequest() as! NSFetchRequest<Stock>
        /*
         List the stocks in alphabetical order with respect to symbol;
         */
        
        request.sortDescriptors = [
            // Primary sort key: rating
            NSSortDescriptor(key: "symbol", ascending: true),

        ]
        return request
    }
   
    /*
     ❎ CoreData @FetchRequest in SearchDatabase.swift invokes this Trip class method
        to fetch filtered Trip entities from the database for the given search query.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Trip.filteredTripsFetchRequest() in any .swift file in your project.
     */
    /*
    static func filteredTripsFetchRequest(searchCategory: String, searchQuery: String) -> NSFetchRequest<Trip> {
       
        let fetchRequest = NSFetchRequest<Trip>(entityName: "Trip")
       
        /*
         List the found trips in alphabetical order with respect to artistName;
         */
        fetchRequest.sortDescriptors = [
            // Primary sort key: artistName
            NSSortDescriptor(key: "rating", ascending: false),
            // Secondary sort key: songName
            NSSortDescriptor(key: "title", ascending: true)
        ]
       
        // Case insensitive search [c] for searchQuery under each category
        switch searchCategory {
        case "Trip Cost":
            fetchRequest.predicate = NSPredicate(format: "cost <= %@", searchQuery)
        case "Trip Rating":
            fetchRequest.predicate = NSPredicate(format: "rating CONTAINS[c] %@", searchQuery)
        case "Trip Title":
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[c] %@", searchQuery)
        case "Trip Start Date":
            fetchRequest.predicate = NSPredicate(format: "startDate CONTAINS[c] %@", searchQuery)
        case "Trip End Date":
            fetchRequest.predicate = NSPredicate(format: "endDate CONTAINS[c] %@", searchQuery)
        case "Trip Notes":
            fetchRequest.predicate = NSPredicate(format: "notes CONTAINS[c] %@", searchQuery)
        case "Compound":
            let components = searchQuery.components(separatedBy: "AND")
            let genreQuery = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let ratingQuery = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
 
            fetchRequest.predicate = NSPredicate(format: "startDate CONTAINS[c] %@ AND rating CONTAINS[c] %@", genreQuery, ratingQuery)
        default:
            print("Search category is out of range")
        }
       
        return fetchRequest
    }
 */
}

