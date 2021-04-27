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
            VStack{
                Section(header: Text("Net Balance")) {
                    Text("\(userData.addedBalance - userData.userBalance)")
                }
                
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
           
        }
            
            
        } // End of Form
        
    } // End of body
}


