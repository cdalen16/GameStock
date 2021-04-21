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
var stockSymbols = [String]()

func api() {
    apiGetSymbols()
    for symbol in stockSymbols {
        apiGetStockData(stockSymbol: symbol)
    }
}


func apiGetSymbols() {
    let apiUrl = "https://cloud.iexapis.com/ref-data/symbols?token=\(secretAPIToken)"
    var apiQueryUrlStruct: URL?
       
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        return
    }
     
    
       
    let headers = [
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "close",
        "host": "cloud.iexapis.com"
    ]
     
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
     
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
     
      
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the JSON file from the API is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
     
        // Process input parameter 'error'
        guard error == nil else {
            // cocktailFound will have the initial values set as above
            semaphore.signal()
            return
        }
           
        /*
            ---------------------------------------------------------
            🔴 Any 'return' used within the completionHandler Closure
            exits the Closure; not the public function it is in.
            ---------------------------------------------------------
            */
     
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
     
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            // countryFound will have the initial values set as above
            semaphore.signal()
               return
        }
     
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
                Foundation framework’s JSONSerialization class is used to convert JSON data
                into Swift data types such as Dictionary, Array, String, Number, or Bool.
                */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                                options: JSONSerialization.ReadingOptions.mutableContainers)
            if let data = jsonResponse as? [[String : Any]] {
                for stock in data {
                    if let symbol = stock["symbol"] {
                        stockSymbols.append(symbol as? String ?? "")
                    }
                }
            }
            
        } catch {
            semaphore.signal()
            return
            }
        semaphore.signal()
    }).resume()
}


func apiGetStockData(stockSymbol: String) {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let StockEntity = Stock(context: managedObjectContext)
   
    let apiUrl = "https://cloud.iexapis.com/stable/tops?token=\(secretAPIToken)&symbols=\(stockSymbol)"
    var apiQueryUrlStruct: URL?
       
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        return
    }
     
    
       
    let headers = [
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "close",
        "host": "cloud.iexapis.com"
    ]
     
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
     
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
     
      
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the JSON file from the API is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
     
        // Process input parameter 'error'
        guard error == nil else {
            // cocktailFound will have the initial values set as above
            semaphore.signal()
            return
        }
           
        /*
            ---------------------------------------------------------
            🔴 Any 'return' used within the completionHandler Closure
            exits the Closure; not the public function it is in.
            ---------------------------------------------------------
            */
     
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
     
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            // countryFound will have the initial values set as above
            semaphore.signal()
               return
        }
     
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
                Foundation framework’s JSONSerialization class is used to convert JSON data
                into Swift data types such as Dictionary, Array, String, Number, or Bool.
                */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                                options: JSONSerialization.ReadingOptions.mutableContainers)
            if let data = jsonResponse as? [String : Any] {
                print(data)
            }
            
        } catch {
            semaphore.signal()
            return
            }
        semaphore.signal()
    }).resume()
}
