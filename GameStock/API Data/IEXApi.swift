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

var publicAPIToken = "pk_f8be26d2c6644a89942aa1a3b226ec09"

let top25StockSymbols = ["aapl", "fb", "googl", "msft", "amzn", "tsla", "intc", "ocgn", "sypr", "amd", "ge", "aal", "f", "pfe", "wfc", "nok", "x", "riot", "amc", "twtr", "rail", "xom", "orcl", "nclh", "mvis"]
var homeStocks = [StockStruct]()

func getHomeStocks() {
    for symbol in top25StockSymbols {
        homeStocks.append(apiGetStockData(stockSymbol: symbol))
    }
}

var stockSymbols = [String]()

//func getHomeStocks() {
//    for symbol in top25StockSymbols {
//        homeStocks.append(apiGetStockData(stockSymbol: symbol))
//    }
//}
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


func apiGetStockData(stockSymbol: String) -> StockStruct {

    let apiUrlMain = "https://cloud.iexapis.com/stable/stock/\(stockSymbol)/quote/latestPrices?token=\(publicAPIToken)"
    
    let jsonDataFromApiMain = getJsonDataFromApi(apiUrl: apiUrlMain)
    
    if(jsonDataFromApiMain == nil){
        return StockStruct(id: UUID(), high: 0.0, low: 0.0, percentChange: 0.0, isMarketOpen: false, label: "", latestPrice: 0.0, primaryExchange: "", symbol: "", name: "", imgURL: "", latitude: 0.0, longitude: 0.0)
    }
    
    do {
        let jsonResponseMain = try JSONSerialization.jsonObject(with: jsonDataFromApiMain!,
                           options: JSONSerialization.ReadingOptions.mutableContainers)
        
        var high = 0.0
        var low = 0.0
        var percentChange = 0.0
        var isMarketOpen = false
        var label = ""
        var latestPrice = 0.0
        var primaryExchange = ""
        var symbol = ""
        var address = ""
        var companyName = ""
        var hqLatitude = 0.0
        var hqLongitude = 0.0
        var logoUrl = ""
        var state = ""
        var city = ""

        if let dataMain = jsonResponseMain as? [String : Any] {
            if let newHigh = dataMain["week52High"] {
                high = newHigh as? Double ?? 0.0
            }
            if let newLow = dataMain["week52Low"] {
                low = newLow as? Double ?? 0.0
            }
            if let newPercentChange = dataMain["changePercent"] {
                percentChange = newPercentChange as? Double ?? 0.0
            }
            if let newIsMarketOpen = dataMain["isUSMarketOpen"] {
                isMarketOpen = newIsMarketOpen as? Bool ?? false
            }
            if let newLabel = dataMain["label"] {
                label = newLabel as? String ?? ""
            }
            if let newLatestPrice = dataMain["latestPrice"] {
                latestPrice = newLatestPrice as? Double ?? 0.0
            }
            if let newPrimaryExchange = dataMain["primaryExchange"] {
                primaryExchange = newPrimaryExchange as? String ?? ""
            }
            if let newSymbol = dataMain["symbol"] {
                symbol = newSymbol as? String ?? ""
            }
            
            //Retrieves necessary company info for a company core data model
            
            let apiUrlCompany = "https://cloud.iexapis.com/stable/stock/\(symbol)/company?token=\(publicAPIToken)"
            
            let jsonDataFromApiCompany = getJsonDataFromApi(apiUrl: apiUrlCompany)
            
            if(jsonDataFromApiCompany == nil){
                return StockStruct(id: UUID(), high: 0.0, low: 0.0, percentChange: 0.0, isMarketOpen: false, label: "", latestPrice: 0.0, primaryExchange: "", symbol: "", name: "", imgURL: "", latitude: 0.0, longitude: 0.0)
            }
            do {
                let jsonResponseCompany = try JSONSerialization.jsonObject(with: jsonDataFromApiCompany!,
                                   options: JSONSerialization.ReadingOptions.mutableContainers)
                
                
                
                if let dataCompany = jsonResponseCompany as? [String : Any] {
                    if let newAddress = dataCompany["address"] {
                        address = newAddress as? String ?? ""
                    }
                    if let newState = dataCompany["state"] {
                        state = newState as? String ?? ""
                    }
                    if let newCity = dataCompany["city"] {
                        city = newCity as? String ?? ""
                    }
                    if let newCompanyName = dataCompany["companyName"] {
                        companyName = newCompanyName as? String ?? ""
                    }
                }
                if address != "" {
                    let mapDetails = getLatLong(addressInput: "\(address),\(city),\(state)")
                    hqLatitude = mapDetails[0].latitude
                    hqLongitude = mapDetails[0].longitude
                    
                }
                
               
                
                    
            } catch {
                print("Failed trying to get API Company Data")
            }
            
            //Retrieves the logo for the company
            
            let apiUrlLogo = "https://cloud.iexapis.com/stable/stock/\(symbol)/logo?token=\(publicAPIToken)"
            
            let jsonDataFromApiLogo = getJsonDataFromApi(apiUrl: apiUrlLogo)
            
            if(jsonDataFromApiLogo == nil){
                
                return StockStruct(id: UUID(), high: 0.0, low: 0.0, percentChange: 0.0, isMarketOpen: false, label: "", latestPrice: 0.0, primaryExchange: "", symbol: "", name: "", imgURL: "", latitude: 0.0, longitude: 0.0)
            }
            do {
                let jsonResponseLogo = try JSONSerialization.jsonObject(with: jsonDataFromApiLogo!,
                                   options: JSONSerialization.ReadingOptions.mutableContainers)
                
                
                
                if let dataLogo = jsonResponseLogo as? [String : Any] {
                    if let newLogoUrl = dataLogo["url"] {
                        logoUrl = newLogoUrl as? String ?? ""
                    }
                }
                    
            } catch {
                print("Failed trying to get API Logo Data")
            }

        }

        let nStock = StockStruct(id: UUID(), high: high, low: low, percentChange: percentChange, isMarketOpen: isMarketOpen, label: label, latestPrice: latestPrice, primaryExchange: primaryExchange, symbol: symbol, name: companyName, imgURL: logoUrl, latitude: hqLatitude, longitude: hqLongitude)
        
        return nStock

        
    } catch {
        print("Failed trying to get API Main Data")
    }
    return StockStruct(id: UUID(), high: 0.0, low: 0.0, percentChange: 0.0, isMarketOpen: false, label: "", latestPrice: 0.0, primaryExchange: "", symbol: "", name: "", imgURL: "", latitude: 0.0, longitude: 0.0)
}

func apiGetStockChart(stockSymbol: String, Duration: String) -> [HisStockData] {
    var searchResults = [HisStockData]()
    
       
    //let apiUrl = "https://cloud.iexapis.com/stable/tops?token=\(publicAPIToken)&symbols=\(stockSymbol)"
    let apiUrlMain = "https://cloud.iexapis.com/stable/stock/\(stockSymbol)/chart/\(Duration)/?token=\(publicAPIToken)"
    
    let jsonDataFromApiMain = getJsonDataFromApi(apiUrl: apiUrlMain)
    
    if(jsonDataFromApiMain == nil){
        return [HisStockData]()
    }
    
    do {
        let jsonResponseMain = try JSONSerialization.jsonObject(with: jsonDataFromApiMain!,
                           options: JSONSerialization.ReadingOptions.mutableContainers)
        
        
        if let jsonObject = jsonResponseMain as? [Dictionary <String, Any>]{
            
            for item in jsonObject{
                
                let stockSymbol = item["symbol"] as? String ?? ""
                let fOpen = item["fOpen"] as? Double ?? 0.0
                let fClose = item["fClose"] as? Double ?? 0.0
                let fHigh = item["fHigh"] as? Double ?? 0.0
                let fLow = item["fLow"] as? Double ?? 0.0
                let fVolume = item["fVolume"] as? Int ?? 0
                let date = item["date"] as? String ?? ""
                let priceChange = item["priceChange"] as? Double ?? 0.0
                let changePercent = item["changePercent"] as? Double ?? 0.0
                
                
                let newChart = HisStockData(id: UUID(), stockSymbol: stockSymbol, fOpen: fOpen, fClose: fClose, fHigh: fHigh, fLow: fLow, fVolume: fVolume, date: date, priceChange: priceChange, changePercent: changePercent)
                
                searchResults.append(newChart)
                
            }
            
            
        } else { return [HisStockData]()}
        
        
    
        
        
        
        
    } catch {
        print("Failed trying to get API Main Data")
    }
    return searchResults

}
