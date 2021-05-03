//
//  Home.swift
//  GameStock
//
//  Created by CS3714 on 4/20/21.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var userData: UserData
    
//    var amountDepoFormatter: Text {
//        let inAmount = userData.userBalance
//
//            // Add thousand separators to trip cost
//            let numberFormatter = NumberFormatter()
//            numberFormatter.numberStyle = .decimal
//            numberFormatter.usesGroupingSeparator = true
//            numberFormatter.groupingSize = 3
//
//            let amountString = "$" + numberFormatter.string(from: inAmount as NSNumber)!
//            return Text(amountString)
//        }
    var body: some View {
        NavigationView {
            List {
                ForEach(homeStocks) { aStock in
                    NavigationLink(destination: StockDetails(stockDet: aStock, ofStock: Stock(), own: false)){
                        StockItem(stock: aStock)
                    }
                }
            }   // End of List
            .navigationBarTitle(Text("Hot Stocks"), displayMode: .large)
        }// End of NavigationView
        .customNavigationViewStyle()
    }   // End of body
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
