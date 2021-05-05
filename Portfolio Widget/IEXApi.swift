//
//  IEXApi.swift
//  Portfolio WidgetExtension
//
//  Created by CS3714 on 5/3/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

var publicAPIToken = "pk_735b57c54441439d8db9c5ccffb3e3aa"

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
//                    let mapDetails = getLatLong(addressInput: "\(address),\(city),\(state)")
                    hqLatitude = 0.0
                    hqLongitude = 0.0
                    
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

public func getJsonDataFromApi(apiUrl: String) -> Data? {
 
    var apiQueryUrlStruct: URL?
    
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        return nil
    }
 
    let jsonData: Data?
    do {
        /*
        Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
        Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
        */
        jsonData = try Data(contentsOf: apiQueryUrlStruct!, options: Data.ReadingOptions.mappedIfSafe)
        return jsonData
       
    } catch {
        return nil
    }
}
