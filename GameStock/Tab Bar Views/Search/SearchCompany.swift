//
//  SearchCompany.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct SearchCompany: View {
    
    @State private var searchFieldValue = ""
    @State private var showSearchFieldEmptyAlert = false
    @State private var searchCompleted = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchItem: $searchFieldValue, placeholder: "Search Companies")
                            
//                    .padding(.horizontal)
//                    .padding(.bottom, 50)
                
                if apiGetStockData(stockSymbol: searchFieldValue).latestPrice != 0.0 {
                    List {
                        NavigationLink(destination: StockDetails(stockDet: apiGetStockData(stockSymbol: searchFieldValue))) {
                            StockItem(stock: apiGetStockData(stockSymbol: searchFieldValue))
                        }
                    }//End of List
                } else if searchFieldValue.isEmpty {
                    List {
                        Text("Please enter a search")
                    }//End of List
                } else {
                    List {
                        Text("No company found")
                    }//End of List
                }
                
            }//End of VStack
            .navigationBarTitle(Text("Search a Company"), displayMode: .large)
//            .padding(.top, 50)
            
            
        }   // End of NavigationView
            .customNavigationViewStyle()  // Given in NavigationStyle.swift
        
    }   // End of body
    
    var searchFieldEmptyAlert: Alert {
        Alert(title: Text("The Stock Symbol Field is Empty!"),
              message: Text("Please enter a stock symbol!"),
              dismissButton: .default(Text("OK")))
    }
    
}

struct SearchCompany_Previews: PreviewProvider {
    static var previews: some View {
        SearchCompany()
    }
}
