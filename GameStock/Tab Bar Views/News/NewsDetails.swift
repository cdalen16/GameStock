//
//  NewsDetails.swift
//  GameStock
//
//  Created by CS3714 on 4/26/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct NewsDetails: View {
    let news: NewsStruct
    
    var body: some View {
        Form {
            Section {
                
            }
        }
    }
}

struct NewsDetails_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetails(news: newNews[0])
    }
}
