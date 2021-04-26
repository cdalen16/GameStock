//
//  SearchResult.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct SearchResult: View {
    let stockSymbol: String
    
    var body: some View {
        List {
//            ForEach ()
//            { item in
//                NavigationLink(destination: FavoriteDetails(movie:item))
//                {
//                    FavoriteItem(movie: item)
//                }
//            }
            StockItem(stock: apiGetStockData(stockSymbol: stockSymbol))
        }
        
    }
}

struct SearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SearchResult(stockSymbol: "AAPL")
    }
}
