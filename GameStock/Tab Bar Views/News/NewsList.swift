//
//  NewsList.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct NewsList: View {
    let results: [NewsStruct]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(results) { item in
                    NewsItem(news: item)
                }
            }//End of list
        }//End of navview
        .customNavigationViewStyle()
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList(results: getNews(search: "tesla"))
    }
}
