//
//  NewsList.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct NewsList: View {
    // Environment User data
    @EnvironmentObject var userData: UserData
    
    // State search item
    @State private var searchItem = ""
    
    var body: some View {
        
        
        VStack {
            SearchBar(searchItem: $searchItem, placeholder: "Search Companies")
            Button(action: {
                userData.newsSearchResults = getNews(search: searchItem)
            }) {
                Text("Search")
            }
            List {
                ForEach(userData.newsSearchResults) { item in
                    NavigationLink(destination: WebView(url: item.storyUrl)) {
                        NewsItem(news: item)
                    }
                }
            }//End of list
        } // End of VStack
        .navigationBarTitle(Text("News"), displayMode: .large)
        
        .customNavigationViewStyle()
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
