//
//  IEXApi.swift
//  GameStock
//
//  Created by CS3714 on 4/21/21.
//  Copyright © 2021 GameStock. All rights reserved.
//
import SwiftUI
import CoreData
import Foundation
var secretAPIToken = "sk_c0b797b55c3f43308c995a689ca8829b"
var publicAPIToken = "pk_735b57c54441439d8db9c5ccffb3e3aa"
var stockSymbols = [String]()

func api() {
    apiGetSymbols()
    //for symbol in stockSymbols {
    //    apiGetStockData(stockSymbol: symbol)
    //}
    apiGetStockData(stockSymbol: "googl")
}
func apiGetSymbols() {
    
    let apiUrl = "https://cloud.iexapis.com/ref-data/symbols?token=\(publicAPIToken)"
    
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    if(jsonDataFromApi == nil){
        return
    }
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        if let data = jsonResponse as? [[String : Any]] {
            for stock in data {
                if let symbol = stock["symbol"] {
                    stockSymbols.append(symbol as? String ?? "")
                }
            }
        }
    } catch{
        print("Failed trying to get API Data")
    }
}


func apiGetStockData(stockSymbol: String) {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let StockEntity = Stock(context: managedObjectContext)
   
    //let apiUrl = "https://cloud.iexapis.com/stable/tops?token=\(publicAPIToken)&symbols=\(stockSymbol)"
    let apiUrl = "https://cloud.iexapis.com/stable/tops?token=\(secretAPIToken)&symbols=\(stockSymbol)"
   
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    if(jsonDataFromApi == nil){
        return
    }
    
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let data = jsonResponse as? [String : Any] {
            print(data)
        }
            
    } catch {
        print("Failed trying to get API Data")
    }

}
