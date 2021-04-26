//
//  NewsApiData.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI
import CoreData


import Foundation

var newsAPIToken = "b8d98a99b78d46e1a9ac83b45ed75125"

var newNews = [NewsStruct]()

func getNews(search: String) -> [NewsStruct] {
    
    let apiUrl = "https://newsapi.org/v2/everything?q=\(search)&apiKey=\(newsAPIToken)"
    
    var newsSearch = [NewsStruct]()
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    if(jsonDataFromApi == nil){
        return [NewsStruct]()
    }
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        var newsContent = "", newsTitle = "" , newsDate = Date(), newsAuthor = "", newsUrl = "", newsImageUrl = ""
        
        if let data = jsonResponse as? [String : Any] {
            
            if let arts = data["articles"] as? [Dictionary <String, Any>] {
                
                for story in arts {
                    
                    if let cont = story["content"] as? String {
                        newsContent = cont
                    }
                    if let tit = story["title"] as? String {
                        newsTitle = tit
                    }
                    if let pub = story["publishedAt"] as? Date {
                        newsDate = pub
                    }
                    if let aut = story["author"] as? String {
                        newsAuthor = aut
                    }
                    if let url = story["url"] as? String {
                        newsUrl = url
                    }
                    if let iUrl = story["urlToImage"] as? String {
                        newsImageUrl = iUrl
                    }
                    
                    let nNews = NewsStruct(id: UUID(), headline: newsTitle, author: newsAuthor, datePub: newsDate, content: newsContent, storyUrl: newsUrl, imageUrl: newsImageUrl)
                    newsSearch.append(nNews)
                }
                
                
            }
        }
    } catch{
        print("Failed trying to get API Data")
    }
    
    newNews = newsSearch
    return newsSearch
    
}
