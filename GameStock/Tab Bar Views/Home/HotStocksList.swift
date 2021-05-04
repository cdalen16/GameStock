//
//  HotStocksList.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 5/4/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation
import SwiftUI

struct HotStocksList: View {
    
    var body: some View {
        List {
            ForEach(homeStocks) { aStock in
                NavigationLink(destination: StockDetails(stockDet: aStock, ofStock: Stock(), own: false)){
                    StockItem(stock: aStock)
                }
            }
        }   // End of List
        .navigationBarTitle(Text("Hot Stocks"), displayMode: .large)
        .onAppear{
            getHomeStocks()
        }
        
    }
    
//    func getHomeStocks() {
//        for symbol in top25StockSymbols {
//            homeStocks.append(apiGetStockData(stockSymbol: symbol))
//        }
//    }
    
}
