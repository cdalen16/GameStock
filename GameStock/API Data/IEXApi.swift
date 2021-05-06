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

var publicAPIToken = "pk_735b57c54441439d8db9c5ccffb3e3aa"

let top10StockSymbols = ["aapl", "fb", "googl", "msft", "amzn", "tsla", "intc", "ocgn", "sypr", "amd"]
var homeStocks = [StockStruct]()
var stockSymbols = [String]()


// THIS FUNCTION GETS A LIST OF TOP STOCKS
// THAT ARE SHOWN IN THE HOME TAB
func getHomeStocks() {
    for symbol in top10StockSymbols {
        homeStocks.append(apiGetStockData(stockSymbol: symbol))
    }
}

//
/// THIS FUNCTION GETS A STOCK DATA WITH A GIVEN STOCK SYMBOL
// IT RETURNS A STOCK STRUCT FOR A GIVEN STOCK
/// - Parameter stockSymbol: Stock Symbol
/// - Returns: StockStuct
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


/// THIS FUNCTION GETS A CHART DATA TO BE USED FOR THE LINE CHART IN STOCK DETAILS
/// - Parameters:
///   - stockSymbol: TAKES IN A STOCK SYMBOL AS AN ARGUMENT
///   - Duration: <#Duration description#>
/// - Returns: RETURNS AN ARRAY OF CHART DATA
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



func loadInitialStocksData() {
    // ❎ Get object reference of CoreData managedObjectContext from the persistent container
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<Stock>(entityName: "Stock")
    fetchRequest.sortDescriptors = [
        // Primary sort key: artistName
        NSSortDescriptor(key: "stockSymbol", ascending: true),
        // Secondary sort key: songName
        NSSortDescriptor(key: "numberOfShares", ascending: true)
    ]
    
    var initialStocks = [Stock]()
   
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        initialStocks = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Populate Database Failed!")
        return
    }
   
    if initialStocks.count > 0 {
        // Database has already been populated
        print("Database has already been populated!")
        return
    }
   
    print("Database will be populated!")
    
//    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let applStock = apiGetStockData(stockSymbol: "aapl")
    let googleStock = apiGetStockData(stockSymbol: "googl")
    
    let applStockEntity = Stock(context: managedObjectContext)
    let applCompanyEntitry = Company(context: managedObjectContext)
    let applPhotoEntity = Photo(context: managedObjectContext)

    applStockEntity.numberOfShares = NSNumber(value: 5)
    applStockEntity.stockSymbol = applStock.symbol
    
    applCompanyEntitry.hqLatitude = applStock.latitude as NSNumber
    applCompanyEntitry.hqLongitude = applStock.longitude as NSNumber
    applCompanyEntitry.name = applStock.name as String
    
    applPhotoEntity.imageUrl = applStock.imgURL
    
    applCompanyEntitry.stock = applStockEntity
    applCompanyEntitry.photo = applPhotoEntity
    applPhotoEntity.company = applCompanyEntitry
    
    let googleStockEntity = Stock(context: managedObjectContext)
    let googleCompanyEntitry = Company(context: managedObjectContext)
    let googlePhotoEntity = Photo(context: managedObjectContext)

    googleStockEntity.numberOfShares = NSNumber(value: 2)
    googleStockEntity.stockSymbol = googleStock.symbol
    
    googleCompanyEntitry.hqLatitude = googleStock.latitude as NSNumber
    googleCompanyEntitry.hqLongitude = googleStock.longitude as NSNumber
    googleCompanyEntitry.name = googleStock.name as String
    
    googlePhotoEntity.imageUrl = googleStock.imgURL
    
    googleCompanyEntitry.stock = googleStockEntity
    googleCompanyEntitry.photo = googlePhotoEntity
    googlePhotoEntity.company = googleCompanyEntitry
    
    initialStocks.append(applStockEntity)
    initialStocks.append(googleStockEntity)
    
    // ❎ CoreData Save operation
    do {
        try managedObjectContext.save()
    } catch {
        print("ERROR! Can't save Item to Core Db")
    }
    
}
