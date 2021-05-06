//
//  FavoritesList.swift
//  GameStock
//
//  Created by CS3714 on 4/26/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI
import CoreData
import SwiftUICharts

struct FavoritesList: View {
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all Recipe entities in the database
    @FetchRequest(fetchRequest: Stock.favoritesRequest()) var allStocks: FetchedResults<Stock>
    
    
    
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Recipe entities with all the changes.
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        Form{
            Section(header: Text("")){
                HStack{
                    Spacer()
                    PieChartView(data: getDoubleArrayForChart(), title: "Stock BreakDown")
                    Spacer()
                }
                
            } // End Of Section 
            List {
                /*
                 Each NSManagedObject has internally assigned unique ObjectIdentifier
                 used by ForEach to display the Recipes in a dynamic scrollable list.
                 */
                ForEach(self.allStocks) { aStock in
                    NavigationLink(destination: StockDetails(stockDet: convert(aStock: aStock), ofStock: aStock, own: true)) {
                        StockItem(stock: convert(aStock: aStock))
                    }
                }
                
                
            }   // End of List
            .navigationBarTitle(Text("My Investments"), displayMode: .large)
            // Use single column navigation view for iPhone and iPad
            .navigationViewStyle(StackNavigationViewStyle())
        }
        //        .onAppear{
        //            getNamesAndShares()
        //        }
        
        
    }   // End of body
    
    

    // Gets the Double Array for the PIEChart function
    // It uses the number of Shares that you are invested in times the updated
    // Price of the Stock you are invested in
    /// - Returns: DOuble array
    func getDoubleArrayForChart() -> [Double] {
        var arrayResults = [Double]()
        
        // It goes through allStocks in the coreDataBase and gets the number of shares of the company
        
        for time in allStocks {
            arrayResults.append(Double(NSNumber(value: time.numberOfShares as! Double)) * convert(aStock: time).latestPrice)
            
        }
        
        return arrayResults
    }
    
    // Gets a stockstruct of the given stock by going to the API
    func convert(aStock: Stock) -> StockStruct {
        
        let thisStock = apiGetStockData(stockSymbol: aStock.stockSymbol!)

        return(thisStock)
    }
}   // End of struct


