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
    
    var body: some View {
        NavigationView {
        Form{
            
            Section(header: Text("Net Worth")) {
                userNetWorthFormatter
            }
            Section(header: Text("Current Balance")) {
                userBalanceFormatter
            }
                
            
            Section(header: Text("Show Favorites List")) {
                NavigationLink(destination: FavoritesList()) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("Favorites List")
                            .font(.system(size: 16))
                    }
                }
                .frame(minWidth: 300, maxWidth: 500)
            }
//            Section(header: Text("Show Watch List")) {
//                NavigationLink(destination: FavoritesList()) {
//                    HStack {
//                        Image(systemName: "list.bullet")
//                            .imageScale(.medium)
//                            .font(Font.title.weight(.regular))
//                            .foregroundColor(.blue)
//                        Text("Watch List")
//                            .font(.system(size: 16))
//                    }
//                }
//                .frame(minWidth: 300, maxWidth: 500)
//            }
            Section(header: Text("Owned Stock Breakdown")) {
                NavigationLink(destination: PieChart()) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("Stock Breakdown")
                            .font(.system(size: 16))
                    }
                }
                .frame(minWidth: 300, maxWidth: 500)
            }
           
        }//End of Form
        .navigationBarTitle(Text("My Portfolio"), displayMode: .large)
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
        let inAmount = userData.addedBalance - userData.userBalance
           
            // Add thousand separators to trip cost
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSize = 3
           
            let amountString = "$" + numberFormatter.string(from: inAmount as NSNumber)!
            return Text(amountString)
        }
    
}

