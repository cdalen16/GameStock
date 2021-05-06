//
//  StockStruct.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//
import SwiftUI

/// THIS STRUCT IS USED TO ORGANIZE THE DATA COMING FROM "apiGetStockData()" FUNCTION API'S RESULT
/// IN IEXApi.swift file
/// 
struct StockStruct: Hashable, Codable, Identifiable {
    
    var id: UUID
    var high: Double
    var low: Double
    var percentChange: Double
    var isMarketOpen: Bool
    var label: String
    var latestPrice: Double
    var primaryExchange: String
    var symbol: String
    var name: String
    var imgURL: String
    var latitude: Double
    var longitude: Double
    
}

