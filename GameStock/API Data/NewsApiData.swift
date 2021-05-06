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

var newsAPIToken = "0a4cc5d87e344b1f96f3151210b07c81"

var newNews = [NewsStruct]()

/// Get news API list from newsAPI.org lets you also search the api to get a news match with a keyword
/// - Parameter search: Key word to get news
/// - Returns: RETURNS A NEWS STRUCT
func getNews(search: String) -> [NewsStruct] {
    
    
    var apiUrl = ""
    if search.isEmpty {
        apiUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(newsAPIToken)"
    } else {
        let searchFixed = search.replacingOccurrences(of: " ", with: "%20")
        apiUrl = "https://newsapi.org/v2/everything?qInTitle=\(searchFixed)&language=en&sortBy=popularity&apiKey=\(newsAPIToken)"
    }
    
    var newsSearch = [NewsStruct]()
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    if(jsonDataFromApi == nil){
        return [NewsStruct]()
    }
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        var newsContent = "", newsTitle = "" , newsDate = "", newsAuthor = "", newsUrl = "", newsImageUrl = ""
        
        if let data = jsonResponse as? [String : Any] {
            
            if let arts = data["articles"] as? [Dictionary <String, Any>] {
                
                for story in arts {
                    
                    if let cont = story["content"] as? String {
                        newsContent = cont
                    }
                    if let tit = story["title"] as? String {
                        newsTitle = tit
                    }
                    if let pub = story["publishedAt"] as? String {
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
