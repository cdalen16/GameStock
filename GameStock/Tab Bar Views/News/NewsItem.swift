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
                .frame(width: 120, height: 85)
            VStack {
                Text(news.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(width:200, height: 60, alignment: .leading)
                Text(getDate())
                    .frame(width:200, height: 25, alignment: .leading)
            }
            .font(.system(size: 14))
        }
    }
    
    func getDate() -> String {
        /*
                 stringDate comes from the API in different formats after minutes:
                     2020-01-20T15:58:17Z
                     2020-01-19T15:00:11+00:00
                     2020-01-15T18:53:26.2988181Z
                 We only need first 16 characters of stringDate, i.e., 2020-01-20T15:58
                 */
               
        // Take the first 16 characters of stringDate
        let firstPart = self.news.datePub.prefix(16)
               
        // Convert firstPart substring to String
        let cleanedStringDate = String(firstPart)
                
        // Create an instance of DateFormatter
        let dateFormatter = DateFormatter()
               
        // Set date format and locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")
                
        // Convert date String to Date struct
        let dateStruct = dateFormatter.date(from: cleanedStringDate)
                
        // Create a new instance of DateFormatter
        let newDateFormatter = DateFormatter()
                
        newDateFormatter.locale = Locale(identifier: "en_US")
        newDateFormatter.dateStyle = .medium    // Jan 18, 2020
        newDateFormatter.timeStyle = .medium    // at 12:26 PM
                
        // Obtain newly formatted Date String as "Jan 18, 2020 at 12:26 PM"
        let dateWithNewFormat = newDateFormatter.string(from: dateStruct!)
           
        return dateWithNewFormat
    }
}

struct NewsItem_Previews: PreviewProvider {
    static var previews: some View {
        NewsItem(news: newNews[0])
    }
}
