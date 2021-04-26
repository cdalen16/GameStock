//
//  NewsList.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct NewsList: View {
    
    @EnvironmentObject var userData: UserData
//    let results: [NewsStruct]
    @State private var searchItem = ""
    
    var body: some View {
        
//        var searchResults = [NewsStruct]()
        
        NavigationView {
            VStack {
                SearchBar(searchItem: $searchItem, placeholder: "Search Companies")
                Button(action: {
                    userData.newsSearchResults = getNews(search: searchItem)
                }) {
                    Text("Search")
                }
                List {
                    ForEach(userData.newsSearchResults) { item in
                        NewsItem(news: item)
                    }
                }//End of list
            }
            .navigationBarTitle(Text("News"), displayMode: .large)
        }//End of navview
        
        .customNavigationViewStyle()
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
