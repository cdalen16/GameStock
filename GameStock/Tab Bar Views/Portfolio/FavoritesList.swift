//
//  FavoritesList.swift
//  GameStock
//
//  Created by CS3714 on 4/26/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI
import CoreData

struct FavoritesList: View {
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all Recipe entities in the database
    @FetchRequest(fetchRequest: Stock.favoritesRequest()) var allStocks: FetchedResults<Stock>
    
    
    
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Recipe entities with all the changes.
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                /*
                 Each NSManagedObject has internally assigned unique ObjectIdentifier
                 used by ForEach to display the Recipes in a dynamic scrollable list.
                 */
                ForEach(self.allStocks) { aStock in
                    NavigationLink(destination: StockDetails(stockDet: convert(aStock: aStock))) {
                        StockItem(stock: convert(aStock: aStock))
                    }
                }

                
            }   // End of List
                .navigationBarTitle(Text("Favorites"), displayMode: .inline)
                /*
                // Place the Edit button on left and Add (+) button on right of the navigation bar
                .navigationBarItems(leading: EditButton(), trailing:
                    NavigationLink(destination: AddRecipe()) {
                        Image(systemName: "plus")
                })
                */
            
        }   // End of NavigationView
            // Use single column navigation view for iPhone and iPad
            .navigationViewStyle(StackNavigationViewStyle())
        
    }   // End of body
    
    func convert(aStock: Stock) -> StockStruct {
        let thisStock = apiGetStockData(stockSymbol: aStock.stockSymbol as! String)
        print(thisStock)
        return(thisStock)
    }
    
//    /*
//     ------------------------------
//     MARK: - Delete Selected Recipe
//     ------------------------------
//     */
//    func convert(aStock: Stock) -> StockStruct {
//        let high = aStock.high as! Double
//        let low = aStock.low as! Double
//        let percentChange = aStock.percentChange as! Double
//        var isMarketOpen = false
//        if let bool = aStock.percentChange {
//            isMarketOpen = bool as! Bool
//        }
//        let label = aStock.label!
//        let latestPrice = aStock.latestPrice as! Double
//        let primaryExchange = aStock.primaryExchange!
//        let symbol = aStock.symbol!
//        let name = aStock.company!.name!
//        let imgURL = aStock.company!.photo!.imageUrl!
//        let latitude = aStock.company!.hqLatitude as! Double
//        let longitude = aStock.company!.hqLongitude as! Double
//        return StockStruct(id: UUID(), high: high, low: low, percentChange: percentChange, isMarketOpen: isMarketOpen, label: label, latestPrice: latestPrice, primaryExchange: primaryExchange, symbol: symbol, name: name, imgURL: imgURL, latitude: latitude, longitude: longitude)
//    }
}   // End of struct


