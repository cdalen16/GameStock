//
//  MainView.swift
//  GameStock
//
//  Created by CS3714 on 4/20/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Portfolio()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Portfolio")
                }
            SearchCompany()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search Stocks")
                }
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
           
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }

}
