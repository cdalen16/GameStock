//
//  Portfolio.swift
//  GameStock
//
//  Created by CS3714 on 4/26/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct Portfolio: View {
    
    @EnvironmentObject var userData: UserData
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    // ❎ CoreData FetchRequest returning all Recipe entities in the database
    @FetchRequest(fetchRequest: Stock.favoritesRequest()) var allStocks: FetchedResults<Stock>
    
    var body: some View {
        NavigationView {
        Form{
            
            Section(header: Text("Net Worth")) {
                userNetWorthFormatter
            }
            Section(header: Text("Current Balance")) {
                userBalanceFormatter
            }
                
            
            Section(header: Text("Show My Investments")) {
                NavigationLink(destination: FavoritesList()) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("My Investments")
                            .font(.system(size: 16))
                    }
                }
                .frame(minWidth: 300, maxWidth: 500)
            }
            Section(header: Text("Show Watch List")) {
                NavigationLink(destination: FavoritesList()) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("Watch List")
                            .font(.system(size: 16))
                    }
                }
                .frame(minWidth: 300, maxWidth: 500)
            }
//            Section(header: Text("Owned Stock Breakdown")) {
//                NavigationLink(destination: PieChart()) {
//                    HStack {
//                        Image(systemName: "list.bullet")
//                            .imageScale(.medium)
//                            .font(Font.title.weight(.regular))
//                            .foregroundColor(.blue)
//                        Text("Stock Breakdown")
//                            .font(.system(size: 16))
//                    }
//                }
//                .frame(minWidth: 300, maxWidth: 500)
//            }
           
        }//End of Form
        .navigationBarTitle(Text("My Portfolio"), displayMode: .large)
        .onAppear() {
            self.userData.startTimer()
            self.userData.currStocksInvested = [Stock]()
            for aStock in allStocks {
                self.userData.currStocksInvested.append(aStock)
            }
        }
        .onDisappear() {
            self.userData.stopTimer()
        }
        }// End of NavView
    } // End of body
    
    var userBalanceFormatter: Text {
        let inAmount = userData.userBalance
           
            // Add thousand separators to trip cost
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSize = 3
           
            let amountString = "$" + numberFormatter.string(from: inAmount as NSNumber)!
            return Text(amountString)
        }
    
    var userNetWorthFormatter: Text {
        let inAmount = userData.stockValue
           
            // Add thousand separators to trip cost
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSize = 3
           
            let amountString = "$" + numberFormatter.string(from: inAmount as NSNumber)!
            return Text(amountString)
        }
    
}

