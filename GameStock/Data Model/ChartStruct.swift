//
//  ChartStruct.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 4/26/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation
import SwiftUI

struct HisStockData: Hashable, Codable, Identifiable {
    
    var id: UUID
    var stockSymbol: String
    var fOpen: Double
    var fClose: Double
    var fHigh: Double
    var fLow: Double
    var fVolume: Int
    var date: String
    var priceChange: Double
    var changePercent: Double
    
    
}
    
/*
 {"close":61.26,"high":61.87,"low":59.28,"open":61.52,"symbol":"TWTR","volume":15582643,"id":"HISTORICAL_PRICES","key":"TWTR","subkey":"","date":"2021-03-26","updated":1616807792000,"changeOverTime":0,"marketChangeOverTime":0,"uOpen":61.52,"uClose":61.26,"uHigh":61.87,"uLow":59.28,"uVolume":15582643,"fOpen":61.52,"fClose":61.26,"fHigh":61.87,"fLow":59.28,"fVolume":15582643,"label":"Mar 26, 21","change":0,"changePercent":0},
 */
