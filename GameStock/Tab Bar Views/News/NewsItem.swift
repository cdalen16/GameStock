//
//  NewsItem.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct NewsItem: View {
    
    let news: NewsStruct
    
    var body: some View {

        HStack {
            getImageFromUrl(url: news.imageUrl, defaultFilename: "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120)
            VStack {
                Text(news.headline)
            }
        }
    }
}

struct NewsItem_Previews: PreviewProvider {
    static var previews: some View {
        NewsItem(news: newNews[0])
    }
}
